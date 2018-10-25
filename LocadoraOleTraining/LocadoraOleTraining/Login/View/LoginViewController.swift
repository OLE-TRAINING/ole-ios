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
    
    var emailUser: String?
    var loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginViewModel.startLogin(labelTitle: labelTitle, labelEmail: labelEmail, viewInvalidData: viewInvalidData, emailUser: emailUser)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func logInButton(_ sender: UIButton) {
        guard let email = emailUser else { return }
        loginViewModel.authenticateUser(email: email, textFieldPassword: textFieldPassword)
        
//        guard let senha = textFieldPassword.text else { return }
//        guard  let email = labelEmail.text else { return }

//        APIManager.shared.getUserWithEmail(email) { (user: Users?) in
//            if user?.password == senha {
//                self.viewInvalidData.isHidden = true
//                ValidateForm.showAlertSucess()
//            }
//            else {
//                self.viewInvalidData.isHidden = false
//            }
//        }

    }
    @IBAction func buttonForgotPassword(_ sender: UIButton) {
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
}
