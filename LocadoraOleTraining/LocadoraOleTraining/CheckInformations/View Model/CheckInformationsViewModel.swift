//
//  CheckInformationsViewModel.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 25/10/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import Foundation

class CheckInformationsViewModel {
    
    var stackViewUsername : UIStackView!
    var email = String()
    
    init() {
        
    }
    
    func checkInformations(email: String?, labelTitle: UILabel, labelEmail: UILabel, stackViewUsername: UIStackView) {
        
        guard let email = email else { return }
        self.email = email
        
        let textColor = UIColor(red: 0.357, green: 0.353, blue: 0.353, alpha: 1)
        Attributes.setAttributesLabel(label: labelTitle, labelText: "CONFIRME AS INFORMAÇÕES DE SUA CONTA", size: 16, fontFamily: "Dosis-Bold", spaceLine: 3.3, textColor: textColor)
        Attributes.setAttributesLabel(label: labelEmail, labelText: email, size: 12.5, fontFamily: "Roboto-Regular", spaceLine: 0.6, textColor: textColor)
        
        self.stackViewUsername = stackViewUsername
        stackViewUsername.isHidden = true
    }
    
    func checkUsername(textFieldUsername: UITextField) -> Bool {
        guard let username = textFieldUsername.text else { return false }
        if ValidateForm.checkUsername(username: username) {
            Attributes.setInicialAttributes(textField: textFieldUsername, stackView: self.stackViewUsername)
            return true
        } else {
            Attributes.setAttributeInvalidField(textField: textFieldUsername, stackView: self.stackViewUsername)
            return false
        }
    }
    
    func validateUsername(textFieldUsername: UITextField, button: UIButton, loading: UIActivityIndicatorView, completion: @escaping(Bool) -> Void ) {
        guard let username = textFieldUsername.text else { return }
            APIManager.shared.getUserWithEmail(email) { (user) in
                if username == user?.username {
                    Attributes.setInicialAttributes(textField: textFieldUsername, stackView: self.stackViewUsername)
                    APIManager.shared.confirmUserInformation(email: self.email, username: username, completion: {(result) in
                        guard let result = result else { return }
                        if result {
                            APIManager.shared.generateToken(email: self.email, completion: {(result) in
                                if result {
                                    completion(true)
                                }
                            })
                        }
                    })
                } else {
                    self.showLoading(status: false, button: button, loading: loading)
                    Attributes.setAttributeInvalidField(textField: textFieldUsername, stackView: self.stackViewUsername)
                    completion(false)
                }
            }
        
    }
    
    func showLoading(status: Bool, button: UIButton, loading: UIActivityIndicatorView)
    {
        ValidateForm.showLoading(status: status, button: button, loading: loading)
    }
    
    func disableButton(button: UIButton) {
        ValidateForm.disableButton(button: button, bool: true)
    }
    
    func enableButton(button: UIButton) {
        ValidateForm.disableButton(button: button, bool: false)
    }
}
