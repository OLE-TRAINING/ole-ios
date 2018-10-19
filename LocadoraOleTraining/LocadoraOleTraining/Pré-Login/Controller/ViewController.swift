//
//  ViewController.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 10/10/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var buttonGo: UIButton!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var stackInvalidEmail: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textColor = UIColor(red: 0.357, green: 0.353, blue: 0.353, alpha: 1)
        Attributes.setAttributesLabel(label: labelEmail, labelText: "INFORME SUA CONTA DE E-MAIL", size: 16, fontFamily: "Dosis-Bold", spaceLine: 3.0, textColor: textColor)
        stackInvalidEmail.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func buttonGo(_ sender: UIButton) {
        
        guard let email = textFieldEmail.text else { return }
        if ValidateForm.checkEmail(email) {
            Attributes.setInicialAttributes(textField: textFieldEmail, stackView: stackInvalidEmail)
            APIManager.shared.getUserWithEmail(email, completion: { [weak self] (user: UsersInfo?) in
                if user?.registrationStatus == "UNEXISTENT" {
                    //email não existe
                    self?.goToRegistrationScreen() 
                } else if user?.registrationStatus == "PENDING" {
                    //email existe e cadastro está incompleto
                    self?.goToContinueRegistrationScreen()
                    
                } else if user?.registrationStatus == "REGISTERED" {
                    //email existe e cadastro está completo
                    self?.goToLoginScreen()
                    
                } else {
                    ValidateForm.showAlertError()
                }
            })
        } else {
            Attributes.setAttributeInvalidField(textField: textFieldEmail, stackView: stackInvalidEmail)
        }
        
    }
}



extension ViewController {

    func goToRegistrationScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "cadastro") as! NewRegistrationViewController
        if let email = textFieldEmail.text {
            controller.emailUser = email
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func goToLoginScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "login") as! LoginViewController
        if let email = textFieldEmail.text {
            controller.emailUser = email
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func goToContinueRegistrationScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "continuarCadastro") as! ContinueRegistration
        if let email = textFieldEmail.text {
            controller.emailUser = email
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
}




