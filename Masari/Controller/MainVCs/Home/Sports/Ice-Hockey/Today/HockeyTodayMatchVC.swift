//
//  HockeyTodayMatchVC.swift
//  Masari
//
//  Created by Hamza Shahbaz on 03/05/2021.
//

import UIKit

class HockeyTodayMatchVC: UIViewController {
    

    //MARK:- Properties
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataSatck: UIStackView!
    var hockey: HockeyModel?
    

    
    //MARK:- Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ConfigureCell(tableView: tableView, collectionView: nil, nibName: "FootballCell", reuseIdentifier: "FootballCell", cellType: .tblView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getMatch()
    }
    
    //MARK:- Supporting Functions
    
    
    func getMatch(){
        
        showLoader()
        HockeyManager.instance.getHockeyTodayMatch {[weak self] (success, baseball, error) in
            if success {
                self?.hideLoader()
                if baseball?.response?.count == 0 {
                    self?.noDataSatck.isHidden = false
                }
                else
                {
                    self?.hockey = baseball
                    self?.noDataSatck.isHidden = true
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                    
                }
            }
            else
            {
                self?.hideLoader()
                Alert.showMsg(msg: error?.localizedDescription ?? "")
            }
        }

    }
    
}

extension HockeyTodayMatchVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hockey?.response?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FootballCell", for: indexPath) as! FootballCell
        let data = hockey?.response
        cell.team1ImgView.sd_setImage(with: URL(string: data?[indexPath.row].teams?.home?.logo ?? ""), placeholderImage: placeHolderLeage, options: .forceTransition, context: nil)
        cell.team2ImgView.sd_setImage(with: URL(string: data?[indexPath.row].teams?.away?.logo ?? ""), placeholderImage: placeHolderLeage, options: .forceTransition, context: nil)
        cell.LblTeam1.text = data?[indexPath.row].teams?.home?.name
        cell.LblTeam2.text = data?[indexPath.row].teams?.away?.name
        if data?[indexPath.row].status?.long == "Finished" || data?[indexPath.row].status?.long == "Finished"  {
            cell.lblRemainingTime.text = data?[indexPath.row].time
            cell.lblScore.text = "\(data?[indexPath.row].status?.long ?? "")"
        }
        else
        {
            cell.lblRemainingTime.text = data?[indexPath.row].status?.long
//            cell.lblScore.text = "[ \(data?[indexPath.row].periods?. ?? 0) : \(data?[indexPath.row].scores?.away?.total ?? 0) ]"

        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
}