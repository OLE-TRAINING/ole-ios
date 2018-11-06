//
//  LoginViewController.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 16/10/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var buttonForgotPassword: UIButton!
    @IBOutlet weak var buttonLogIn: UIButton!
    @IBOutlet weak var viewInvalidData: UIView!
    @IBOutlet weak var loadingForgotPassword: UIActivityIndicatorView!
    @IBOutlet weak var loadingLogIn: UIActivityIndicatorView!
    
    var emailUser: String?
    var loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginViewModel.startLogin(labelTitle: labelTitle, labelEmail: labelEmail, viewInvalidData: viewInvalidData, emailUser: emailUser)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginViewModel.showLoading(status: false, button: buttonLogIn, loading: loadingLogIn)
        loginViewModel.showLoading(status: false, button: buttonForgotPassword, loading: loadingForgotPassword)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.viewControllers.remove(at: 1)
        self.navigationController?.popViewController(animated: true)

    }
    
    @IBAction func logInButton(_ sender: UIButton) {
        loginViewModel.showLoading(status: true, button: buttonLogIn, loading: loadingLogIn)
        guard let email = emailUser else { return }
        loginViewModel.authenticateUser(email: email, textFieldPassword: textFieldPassword, button: buttonLogIn, loading: loadingLogIn, completion: {(result) in
            if result {
                self.goToHomeScreen()
            } else {
                self.loginViewModel.showLoading(status: false, button: self.buttonLogIn, loading: self.loadingLogIn)
            }
        })

    }
    @IBAction func buttonForgotPassword(_ sender: UIButton) {
        loginViewModel.showLoading(status: true, button: buttonForgotPassword, loading: loadingForgotPassword)
        self.goToCheckInformationsScreen()
    }

}


extension LoginViewController {
    func goToCheckInformationsScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "verificaInformacoes") as! CheckInformationsViewController
        if let email = labelEmail.text {
            controller.emailUser = email
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func goToHomeScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "tabBar") as! TabBarController
//        if let email = labelEmail.text {
//            controller.emailUser = email
//        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
