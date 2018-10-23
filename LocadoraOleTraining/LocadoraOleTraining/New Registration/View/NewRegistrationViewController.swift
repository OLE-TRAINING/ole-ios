//
//  CadastroViewController.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 11/10/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

class NewRegistrationViewController: UIViewController {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var buttonGo: UIButton!
    
    @IBOutlet var textFields: [UITextField]!
    
    @IBOutlet weak var textFieldFullName: UITextField!
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    @IBOutlet weak var stackViewFullName: UIStackView!
    @IBOutlet weak var stackViewUsername: UIStackView!
    @IBOutlet weak var stackViewPassword: UIStackView!
    
    
    let textColor = UIColor(red: 0.357, green: 0.353, blue: 0.353, alpha: 1)
    let borderColor = UIColor(red: 0.99, green: 0.098, blue: 0.141, alpha: 1)
    
    var emailUser: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Attributes.setAttributesLabel(label: labelTitle, labelText: "CRIE SUA NOVA\nCONTA", size: 16, fontFamily: "Dosis-Bold", spaceLine: 3.0, textColor: textColor)
        
        if let email = emailUser {
            Attributes.setAttributesLabel(label: labelEmail, labelText: email, size: 12.5, fontFamily: "Roboto-Regular", spaceLine: 0.6, textColor: textColor)
        }
        
        
        stackViewFullName.isHidden = true
        stackViewUsername.isHidden = true
        stackViewPassword.isHidden = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func ButtonGo(_ sender: UIButton) {
        
        if ValidateForm.checkFilledTextFields(textFieldName: textFieldFullName, textFieldUsername: textFieldUsername, textFieldPassword: textFieldPassword){
            
            Attributes.setInicialAttributes(textField: textFieldFullName, stackView: stackViewFullName)
            Attributes.setInicialAttributes(textField: textFieldUsername, stackView: stackViewUsername)
            Attributes.setInicialAttributes(textField: textFieldPassword, stackView: stackViewPassword)
            
            APIManager.shared.createNewUser(email: labelEmail.text!, password: textFieldPassword.text!, completeName: textFieldFullName.text!, username: textFieldUsername.text!, registrationStatus: "PENDING")
            goToValidateTokenScreen()

        } else {
            switch ValidateForm.checkFullName(fullName: textFieldFullName.text ?? "") {
            case true:
                Attributes.setInicialAttributes(textField: textFieldFullName, stackView: stackViewFullName)
            case false:
                Attributes.setAttributeInvalidField(textField: textFieldFullName, stackView: stackViewFullName)
            }
            
            switch ValidateForm.checkUsername(username: textFieldUsername.text ?? "") {
            case true:
                Attributes.setInicialAttributes(textField: textFieldUsername, stackView: stackViewUsername)
            case false:
                Attributes.setAttributeInvalidField(textField: textFieldUsername, stackView: stackViewUsername)
                
            }
            
            switch ValidateForm.checkPassword(password: textFieldPassword.text ?? "") {
            case true:
                Attributes.setInicialAttributes(textField: textFieldPassword, stackView: stackViewPassword)
            case false:
                Attributes.setAttributeInvalidField(textField: textFieldPassword, stackView: stackViewPassword)
            }
            
        }
        
    }
    
}

extension NewRegistrationViewController {
    func goToValidateTokenScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "validarToken") as! ValidateTokenViewController
        if let email = labelEmail.text {
            controller.emailUser = email
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
