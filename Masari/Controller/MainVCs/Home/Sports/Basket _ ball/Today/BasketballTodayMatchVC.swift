//
//  BasketballViewController.swift
//  Masari
//
//  Created by Hamza Shahbaz on 04/05/2021.
//

import UIKit

class BasketballTodayMatchVC: UIViewController {

    //MARK:- Properties
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataSatck: UIStackView!
    var basket: BasketballModel?
    

    
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
        BasketballManager.instance.getBasketBallTodayMatch {[weak self] (success, baseball, error) in
            if success {
                self?.hideLoader()
                if baseball?.response?.count == 0 {
                    self?.noDataSatck.isHidden = false
                }
                else
                {
                    self?.basket = baseball
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
    
    @objc func handleBetNoWTapped(sender: UIButton) {
        let betPopUp = PopUpBet()
        betPopUp.modalPresentationStyle = .overFullScreen
        betPopUp.modalTransitionStyle = .crossDissolve
        self.present(betPopUp, animated: true, completion: nil)
    }
}

extension BasketballTodayMatchVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basket?.response?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FootballCell", for: indexPath) as! FootballCell
        let data = basket?.response
        cell.team1ImgView.sd_setImage(with: URL(string: data?[indexPath.row].teams?.home?.logo ?? ""), placeholderImage: placeHolderLeage, options: .forceTransition, context: nil)
        cell.team2ImgView.sd_setImage(with: URL(string: data?[indexPath.row].teams?.away?.logo ?? ""), placeholderImage: placeHolderLeage, options: .forceTransition, context: nil)
        cell.LblTeam1.text = data?[indexPath.row].teams?.home?.name
        cell.LblTeam2.text = data?[indexPath.row].teams?.away?.name
        cell.btnBetNow.addTarget(self, action: #selector(handleBetNoWTapped(sender:)), for: .touchUpInside)
        cell.btnBetNow.tag = indexPath.row
        if data?[indexPath.row].status?.long == "Game Finished" || data?[indexPath.row].status?.long == "Not Started" || data?[indexPath.row].status?.long == "Game Postponed"{
            cell.lblRemainingTime.text = data?[indexPath.row].status?.long
            cell.betNowView.isHidden = true
        }
        else
        {
            cell.betNowView.isHidden = false
            cell.lblRemainingTime.text = data?[indexPath.row].time
            cell.lblScore.text = data?[indexPath.row].status?.long
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
}
