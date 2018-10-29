//
//  ValidateTokenViewModel.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 25/10/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import Foundation

class ValidateTokenViewModel{
    
    var emailUser = String()
    var stackViewInvalidCode : UIStackView!
    
    init() {
        
    }
    
    func startValidateToken(labelDidNotReceive: UILabel, emailUser: String?, labelTitle: UILabel, labelEmail: UILabel, stackViewInvalidCode: UIStackView) {
        let textColor = UIColor(red: 0.357, green: 0.353, blue: 0.353, alpha: 1)
        guard let email = emailUser else { return }
        self.emailUser = email
        
        Attributes.setAttributesLabel(label: labelTitle, labelText: "PARA SUA SEGURANÇA, INFORME O CÓDIGO ENVIADO PARA O SEU\nE-MAIL:", size: 16, fontFamily: "Dosis-Bold", spaceLine: 3.0, textColor: textColor)
        let emailColor = UIColor(red: 0.99, green: 0.098, blue: 0.141, alpha: 1)
        if let email = emailUser {
            Attributes.setAttributesLabel(label: labelEmail, labelText: email, size: 12, fontFamily: "Roboto-Bold", spaceLine: 0.6, textColor: emailColor)
        }
        
        Attributes.setAttributesLabel(label: labelDidNotReceive, labelText: "Não recebeu o código?", size: 12, fontFamily: "Roboto-Regular", spaceLine: 0.5, textColor: textColor)
        
        self.stackViewInvalidCode = stackViewInvalidCode
        self.stackViewInvalidCode.isHidden = true
    }
    
    func validateToken(textFieldCode: UITextField, button: UIButton, loading: UIActivityIndicatorView, completion: @escaping(Bool) -> Void) {
        guard let code = textFieldCode.text else { return }
        if ValidateForm.checkCode(code) {
            Attributes.setInicialAttributes(textField: textFieldCode, stackView: self.stackViewInvalidCode)
            APIManager.shared.validateToken(textFieldCode: textFieldCode, email: emailUser, completion:  { (response: Bool) in
                if response {
                    completion(true)
                } else {
                    completion(false)
                }
            })
            
        } else {
            showLoading(status: false, button: button, loading: loading)
            Attributes.setAttributeInvalidField(textField: textFieldCode, stackView: self.stackViewInvalidCode)
        }
        
    }
    
    func resendToken() {
        APIManager.shared.generateToken(email: emailUser)
    }
    
    func showLoading(status: Bool, button: UIButton, loading: UIActivityIndicatorView)
    {
        ValidateForm.showLoading(status: status, button: button, loading: loading)
    }

}
