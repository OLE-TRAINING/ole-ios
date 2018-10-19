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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textColor = UIColor(red: 0.357, green: 0.353, blue: 0.353, alpha: 1)
        Attributes.setAttributesLabel(label: labelTitle, labelText: "INFORME SUA SENHA:", size: 16, fontFamily: "Dosis-Bold", spaceLine: 3.0, textColor: textColor)
        if let email = emailUser {
            Attributes.setAttributesLabel(label: labelEmail, labelText: email, size: 12, fontFamily: "Arial", spaceLine: 0.6, textColor: textColor)
        }
        viewInvalidData.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func logInButton(_ sender: UIButton) {
        guard let senha = textFieldPassword.text else { return }
        guard  let email = labelEmail.text else { return }

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
    

}
