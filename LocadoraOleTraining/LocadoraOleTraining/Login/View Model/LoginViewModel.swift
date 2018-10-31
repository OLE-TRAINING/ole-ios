//
//  LoginViewModel.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 25/10/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import Foundation



class LoginViewModel {
    
    var emailUser = String()
    var viewInvalidData = UIView()
    
    func startLogin(labelTitle: UILabel, labelEmail: UILabel, viewInvalidData: UIView, emailUser: String?) {
        let textColor = UIColor(red: 0.357, green: 0.353, blue: 0.353, alpha: 1)
        guard let email = emailUser else { return }
        self.emailUser = email
        
        Attributes.setAttributesLabel(label: labelTitle, labelText: "INFORME SUA SENHA:", size: 16, fontFamily: "Dosis-Bold", spaceLine: 3.0, textColor: textColor)
        Attributes.setAttributesLabel(label: labelEmail, labelText: email, size: 12, fontFamily: "Arial", spaceLine: 0.6, textColor: textColor)
        labelEmail.textAlignment = 	.left
        
        self.viewInvalidData = viewInvalidData
        self.viewInvalidData.isHidden = true
    }
    
    func authenticateUser(email: String, textFieldPassword: UITextField, button: UIButton, loading: UIActivityIndicatorView, completion: @escaping (Bool) -> Void) {
        guard let password = textFieldPassword.text else { return }
        if ValidateForm.checkPassword(password: password) {
            self.viewInvalidData.isHidden = true
            APIManager.shared.authenticateUser(email: email, password: password, completion: { (result) in
                if result {
                    completion(true)
                }
            })
        } else {
            self.viewInvalidData.isHidden = false
            showLoading(status: false, button: button, loading: loading)
        }
    }
    
    func showLoading(status: Bool, button: UIButton, loading: UIActivityIndicatorView)
    {
        ValidateForm.showLoading(status: status, button: button, loading: loading)
    }
}
