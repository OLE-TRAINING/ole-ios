//
//  HomeViewController.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 30/10/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit
import Tabman
import Pageboy

class HomeViewController: UIViewController{
    
    @IBOutlet weak var buttonMenu: UIBarButtonItem!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var leadingMenuConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet var mainView: UIView!
    
    var homeViewModel = HomeViewModel()
    var menuShowing = false
    
    
    //MARK: - MenuItems
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leadingMenuConstraint.constant = -310
        menuView.layer.shadowOpacity = 1
        viewBack.isHidden = true
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        viewBack.addGestureRecognizer(tap)
        
        
        let userEmail = UserDefaults.standard.string(forKey: "email") ?? ""
        
        homeViewModel.setEmailAndUsername(userEmail: userEmail, email: email, username: username)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationItem.titleView = homeViewModel.startHome()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func buttonBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func goToLoginScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "login") as! LoginViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func showMenu(_ sender: Any) {
            viewBack.isHidden = false
            self.tabBarController?.tabBar.layer.zPosition = -1
            self.navigationController?.navigationBar.layer.zPosition = -1
            leadingMenuConstraint.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })

    }
    
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        leadingMenuConstraint.constant = -310
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        viewBack.isHidden = true
    }
    
    @IBAction func buttonLogout(_ sender: UIButton) {
        homeViewModel.logout()
    }
    
}

