//
//  HomeViewController.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 30/10/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {

    @IBOutlet weak var buttonMenu: UIButton!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var pagerView: UIView!
    
    var homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.startHome(labelTitle: labelTitle)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func buttonBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}

//extension HomeViewController: TabmanViewController, PageboyViewControllerDataSource {
//    
//}
