//
//  HomeViewController.swift
//  Masari
//
//  Created by Hamza Shahbaz on 30/03/2021.
//

import UIKit
import LZViewPager


class HomeViewController: UIViewController {
    
    //MARK:- Properties
    
    @IBOutlet weak var betTableView: UITableView!
    @IBOutlet weak var viewPager: LZViewPager!
    
    private var subControllers:[UIViewController] = []
    
    
    //MARK:- controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewPager()
        ConfigureCell(tableView: betTableView, collectionView: nil, nibName: "BetsCell", reuseIdentifier: "BetsCell", cellType: .tblView)
    }
    
    
    //MARK:- Supporting Functions
    
    func setupViewPager(){
        viewPager.dataSource = self
        viewPager.delegate = self
        viewPager.hostController = self
    
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        viewPager.tintColor = #colorLiteral(red: 0.5076961517, green: 0.2106034458, blue: 0.2362745106, alpha: 1)
        let vc1 = mainStoryboard.instantiateViewController(withIdentifier: "SportsViewController") as! SportsViewController
        vc1.title = "Sports"
        let vc2 = mainStoryboard.instantiateViewController(withIdentifier: "CasinoViewController") as! CasinoViewController
        vc2.title = "Casino"
        subControllers = [vc1, vc2]
        viewPager.reload()
    }

    
    //MARK:- Actions
    
    @IBAction func btnMenuTapped(_ sender: Any){
        let controller: MenuViewController = MenuViewController.initiateFrom(Storybaord: .Main)
        self.pushController(contorller: controller, animated: true)
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BetsCell", for: indexPath) as! BetsCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension HomeViewController: LZViewPagerDelegate, LZViewPagerDataSource{
    func numberOfItems() -> Int {
        return self.subControllers.count
    }
    
    func controller(at index: Int) -> UIViewController {
        return subControllers[index]
    }
    
    func button(at index: Int) -> UIButton {
        //Customize your button styles here
        let button = UIButton()
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "TTCommons-Bold", size: 20)
        return button
    }
    
    
    func widthForButton(at index: Int) -> CGFloat {
        return 100.0
    }
    func colorForIndicator(at index: Int) -> UIColor {
        return #colorLiteral(red: 0.2499485314, green: 0.3317975998, blue: 0.8006594181, alpha: 1)
    }
    func widthForIndicator(at index: Int) -> CGFloat {
        return 70
    }
    func heightForIndicator() -> CGFloat {
        return 2
    }
    
}
