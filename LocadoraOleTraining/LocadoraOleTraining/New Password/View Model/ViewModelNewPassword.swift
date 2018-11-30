//
//  ViewModelNewPassword.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 29/10/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import Foundation

class ViewModelNewPassword {
    
    var stackViewInvalidToken: UIStackView!
    var stackViewInvalidPassword: UIStackView!
    var stackViewInvalidConfirmation: UIStackView!
    var textFieldToken: UITextField!
    var textFieldNewPassword: UITextField!
    var textFieldConfirmPassword: UITextField!
    
    var email = String()
    
    init() {
        
    }
    
    func startTitles(labelTitle: UILabel, email: String?, labelEmail: UILabel, labelDidNotReceive: UILabel, labelSubtitle: UILabel) {
        guard let email = email else { return }
        self.email = email
        
        let textColor = UIColor(red: 0.357, green: 0.353, blue: 0.353, alpha: 1)
        Attributes.setAttributesLabel(label: labelTitle, labelText: "PARA SUA SEGURANÇA, INFORME O CÓDIGO ENVIADO PARA O SEU\nE-MAIL:", size: 16, fontFamily: "Dosis-Bold", spaceLine: 3.3, textColor: textColor)
        
        self.email = email
        let emailColor = UIColor(red: 0.99, green: 0.098, blue: 0.141, alpha: 1)
        Attributes.setAttributesLabel(label: labelEmail, labelText: email, size: 12, fontFamily: "Roboto-Bold", spaceLine: 0.6, textColor: emailColor)
        
        Attributes.setAttributesLabel(label: labelSubtitle, labelText: "CRIE SUA NOVA\nSENHA", size: 16, fontFamily: "Dosis-Bold", spaceLine: 3.3, textColor: textColor)
        Attributes.setAttributesLabel(label: labelDidNotReceive, labelText: "Não recebeu o código?", size: 12, fontFamily: "Roboto-Regular", spaceLine: 0.5, textColor: textColor)
        
    }
    
    func startStackViews(textFieldToken: UITextField, textFieldNewPassword: UITextField, textFieldConfirmPassword: UITextField, stackViewInvalidToken: UIStackView, stackViewInvalidPassword: UIStackView, stackViewInvalidConfirmation: UIStackView) {
        self.stackViewInvalidToken = stackViewInvalidToken
        self.stackViewInvalidPassword = stackViewInvalidPassword
        self.stackViewInvalidConfirmation = stackViewInvalidConfirmation
        self.textFieldToken = textFieldToken
        self.textFieldNewPassword = textFieldNewPassword
        self.textFieldConfirmPassword = textFieldConfirmPassword
        
        Attributes.setInicialAttributes(textField: self.textFieldToken, stackView: self.stackViewInvalidToken)
        Attributes.setInicialAttributes(textField: self.textFieldNewPassword, stackView: self.stackViewInvalidPassword)
        Attributes.setInicialAttributes(textField: self.textFieldConfirmPassword, stackView: self.stackViewInvalidConfirmation)
        
    }
    
    func changePassword(button: UIButton, loading: UIActivityIndicatorView, completion: @escaping(Bool) -> Void ) {
        guard let token = textFieldToken.text else { return }
        guard let password = textFieldNewPassword.text else { return }
        guard let confirmationPassword = textFieldConfirmPassword.text else { return }
        if ValidateForm.checkCode(token) {
            Attributes.setInicialAttributes(textField: self.textFieldToken, stackView: self.stackViewInvalidToken)
            if ValidateForm.checkPassword(password: password) {
                Attributes.setInicialAttributes(textField: self.textFieldNewPassword, stackView: self.stackViewInvalidPassword)
                if password == confirmationPassword {
//                    APIManager.shared.validateToken(textFieldCode: textFieldToken, email: self.email) { (result) in
//                        if result {
                            APIManager.shared.changePassword(email: self.email, confirmationToken: token, newPassword: password, newPasswordConfirmation: confirmationPassword, completion: { (result) in
                                if result {
                                    Attributes.setInicialAttributes(textField: self.textFieldNewPassword, stackView: self.stackViewInvalidPassword)
                                    Attributes.setInicialAttributes(textField: self.textFieldConfirmPassword, stackView: self.stackViewInvalidConfirmation)
                                    completion(true)
                                } else {
                                    completion(false)
                                    Attributes.setInicialAttributes(textField: self.textFieldToken, stackView: self.stackViewInvalidToken)
                                    //self.showLoading(status: false, button: button, loading: loading)
                                }

                            })
//                        } else {
//                            self.showLoading(status: false, button: button, loading: loading)
//                            Attributes.setAttributeInvalidField(textField: self.textFieldToken, stackView: self.stackViewInvalidToken)
//                        }
//                    }
                } else {
                    self.showLoading(status: false, button: button, loading: loading)
                    Attributes.setAttributeInvalidField(textField: self.textFieldConfirmPassword, stackView: self.stackViewInvalidConfirmation)
                }

            } else {
                self.showLoading(status: false, button: button, loading: loading)
                Attributes.setAttributeInvalidField(textField: self.textFieldNewPassword, stackView: self.stackViewInvalidPassword)
            }

        } else {
            self.showLoading(status: false, button: button, loading: loading)
            Attributes.setAttributeInvalidField(textField: textFieldToken, stackView: stackViewInvalidToken)
        }
        
            
        
        
    

    }
    
    func resendToken(completion: @escaping (Bool) -> Void){
        APIManager.shared.generateToken(email: email, completion: {(result) in
            if result {
                completion(true)
            }
        })
    }
    
    func showLoading(status: Bool, button: UIButton, loading: UIActivityIndicatorView)
    {
        ValidateForm.showLoading(status: status, button: button, loading: loading)
    }
}
