//
//  NewRegistrationViewModel.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 25/10/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import Foundation

class NewRegistrationViewModel {
    

    var labelEmail: UILabel!
    var stackViewFullName: UIStackView!
    var stackViewUsername: UIStackView!
    var stackViewPassword: UIStackView!
    var textFieldFullName: UITextField!
    var textFieldUsername: UITextField!
    var textFieldPassword: UITextField!
    
    
    var email = String()
    
    init() {
        
    }
    
    func startRegistration(emailUser: String?, labelTitle: UILabel, labelEmail: UILabel, stackViewFullName: UIStackView, stackViewUsername: UIStackView, stackViewPassword: UIStackView) {
        
        self.stackViewFullName = stackViewFullName
        self.stackViewUsername = stackViewUsername
        self.stackViewPassword = stackViewPassword
        self.labelEmail = labelEmail
        
        guard let email = emailUser else { return }
        self.email = email
        
        let textColor = UIColor(red: 0.357, green: 0.353, blue: 0.353, alpha: 1)
        
        Attributes.setAttributesLabel(label: labelTitle, labelText: "CRIE SUA NOVA\nCONTA", size: 16, fontFamily: "Dosis-Bold", spaceLine: 3.0, textColor: textColor)
        Attributes.setAttributesLabel(label: labelEmail, labelText: email, size: 12.5, fontFamily: "Roboto-Regular", spaceLine: 0.6, textColor: textColor)

        self.stackViewFullName.isHidden = true
        self.stackViewUsername.isHidden = true
        self.stackViewPassword.isHidden = true

    }
    
    func disableButton(button: UIButton) {
        ValidateForm.disableButton(button: button, bool: true)
    }
    
    func enableButton(button: UIButton) {
        ValidateForm.disableButton(button: button, bool: false)
    }

    func checkFullName(textFieldFullName: UITextField) -> Bool {
        guard let fullName = textFieldFullName.text else { return false }
        
        switch ValidateForm.checkFullName(fullName: fullName) {
        case true:
            Attributes.setInicialAttributes(textField: textFieldFullName, stackView: stackViewFullName)
            return true
        case false:
            Attributes.setAttributeInvalidField(textField: textFieldFullName, stackView: stackViewFullName)
            return false
        }
    }
    
    func checkUsername(textFieldUsername: UITextField, msgUsername: UILabel) -> Bool {
        guard let username = textFieldUsername.text else { return false }
        
        switch ValidateForm.checkUsername(username: username) {
        case true:
            Attributes.setInicialAttributes(textField: textFieldUsername, stackView: stackViewUsername)
            return true
        case false:
            msgUsername.text = "     Obrigatório conter letras e/ou números, no máximo 15 caracteres"
            Attributes.setAttributeInvalidField(textField: textFieldUsername, stackView: stackViewUsername)
            return false
        }
        
    }
    
    func checkPassword(textFieldPassword: UITextField) -> Bool {
        guard let password = textFieldPassword.text else { return false }
        
        switch ValidateForm.checkPassword(password: password) {
        case true:
            Attributes.setInicialAttributes(textField: textFieldPassword, stackView: stackViewPassword)
            return true
        case false:
            Attributes.setAttributeInvalidField(textField: textFieldPassword, stackView: stackViewPassword)
            return false
        }
        
    }
    
    
    func goToNextScreen(msgUsername: UILabel, button: UIButton, loading: UIActivityIndicatorView, textFieldFullName: UITextField, textFieldUsername: UITextField, textFieldPassword: UITextField,completion: @escaping(Bool?) -> Void) {
        
        showLoading(status: false, button: button, loading: loading)

            Attributes.setInicialAttributes(textField: textFieldFullName, stackView: stackViewFullName)
            Attributes.setInicialAttributes(textField: textFieldUsername, stackView: stackViewUsername)
            Attributes.setInicialAttributes(textField: textFieldPassword, stackView: stackViewPassword)
            
            showLoading(status: true, button: button, loading: loading)
            APIManager.shared.createNewUser(email: labelEmail.text!, password: textFieldPassword.text!, completeName: textFieldFullName.text!, username: textFieldUsername.text!, completion: { (result: Bool?) in
                guard let flag = result else { return }
                if flag {
                    completion(true)
                }
                else {
                    msgUsername.text = "     Nome de usuario já cadastrado"
                    Attributes.setAttributeInvalidField(textField: textFieldUsername, stackView: self.stackViewUsername)
                    completion(false)
                }
            })
        
    }
    
    func showLoading(status: Bool, button: UIButton, loading: UIActivityIndicatorView)
    {
        ValidateForm.showLoading(status: status, button: button, loading: loading)
    }
   
}
