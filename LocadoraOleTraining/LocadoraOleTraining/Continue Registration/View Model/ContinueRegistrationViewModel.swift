//
//  File.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 25/10/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import Foundation

class ContinueRegistrationViewModel {
    
    var emailUser = String()
    var stackInvalidCode = UIStackView()
    
    init() {
        
    }
    
    func continueRegistration(labelDidNotReceive: UILabel, emailUser: String?, labelTitle: UILabel, labelEmail: UILabel, stackInvalidCode: UIStackView) {
        let textColor = UIColor(red: 0.357, green: 0.353, blue: 0.353, alpha: 1)
        guard let email = emailUser else { return }
        self.emailUser = email
        
        Attributes.setAttributesLabel(label: labelTitle, labelText: "IDENTIFICAMOS QUE VOCÊ JÁ INICIOU UM CADASTRO, PARA CONCLUIRMOS, INFORME O TOKEN ENVIADO PARA O SEU E-MAIL:", size: 16, fontFamily: "Dosis-Bold", spaceLine: 3.0, textColor: textColor)
        let emailColor = UIColor(red: 0.99, green: 0.098, blue: 0.141, alpha: 1)
        Attributes.setAttributesLabel(label: labelEmail, labelText: email, size: 12, fontFamily: "Roboto-Bold", spaceLine: 0.6, textColor: emailColor)

        Attributes.setAttributesLabel(label: labelDidNotReceive, labelText: "Não recebeu o token?", size: 12, fontFamily: "Roboto-Regular", spaceLine: 0.5, textColor: textColor)
        
        self.stackInvalidCode = stackInvalidCode
        self.stackInvalidCode.isHidden = true
    }
    
    func checkToken(textFieldToken: UITextField) -> Bool {
        guard let token = textFieldToken.text else { return false }
        if ValidateForm.checkCode(token) {
            Attributes.setInicialAttributes(textField: textFieldToken, stackView: self.stackInvalidCode)
            return true
        } else {
            Attributes.setAttributeInvalidField(textField: textFieldToken, stackView: self.stackInvalidCode)
            return false
        }
    }
    
    func validateToken(textFieldToken: UITextField, button: UIButton, loading: UIActivityIndicatorView, completion: @escaping(Bool) -> Void) {
            APIManager.shared.validateToken(textFieldToken: textFieldToken, email: emailUser, completion:  { (response: Bool) in
                if response {
                    completion(true)
                } else {
                    self.showLoading(status: false, button: button, loading: loading)
                    Attributes.setAttributeInvalidField(textField: textFieldToken, stackView: self.stackInvalidCode)
                    completion(false)
                }
            })
   
        
    }
    
    func showLoading(status: Bool, button: UIButton, loading: UIActivityIndicatorView)
    {
        ValidateForm.showLoading(status: status, button: button, loading: loading)
    }
    
    func resendToken(completion: @escaping (Bool) -> Void){
        APIManager.shared.generateToken(email: emailUser, completion: {(result) in
            if result {
                completion(true)
            }
        })
    }
    
    func disableButton(button: UIButton) {
        ValidateForm.disableButton(button: button, bool: true)
    }
    
    func enableButton(button: UIButton) {
        ValidateForm.disableButton(button: button, bool: false)
    }

}
