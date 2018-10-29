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
    
    func goToNextScreen(textFieldFullName: UITextField, textFieldUsername: UITextField, textFieldPassword: UITextField,completion: @escaping(Bool?) -> Void) {
        if ValidateForm.checkFilledTextFields(textFieldName: textFieldFullName, textFieldUsername: textFieldUsername, textFieldPassword: textFieldPassword){
            
            Attributes.setInicialAttributes(textField: textFieldFullName, stackView: stackViewFullName)
            Attributes.setInicialAttributes(textField: textFieldUsername, stackView: stackViewUsername)
            Attributes.setInicialAttributes(textField: textFieldPassword, stackView: stackViewPassword)
            
            APIManager.shared.createNewUser(email: labelEmail.text!, password: textFieldPassword.text!, completeName: textFieldFullName.text!, username: textFieldUsername.text!, completion: { (result: Bool?) in
                if let _ = result {
                    completion(true)
                }
                else {
                    ValidateForm.showAlertError()
                    completion(false)
                }
            })
            
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
