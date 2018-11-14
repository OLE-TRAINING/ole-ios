//
//  ViewModel.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 23/10/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import Foundation



class PreLoginViewModel {

    var labelEmail: UILabel!
    var stackInvalidEmail: UIStackView!
    var email: String?

    
    
    init() {
        
    }
    
    
    func startAplication(labelEmail: UILabel, stackInvalidEmail: UIStackView) {
        self.labelEmail = labelEmail
        self.stackInvalidEmail = stackInvalidEmail
        
        let textColor = UIColor(red: 0.357, green: 0.353, blue: 0.353, alpha: 1)
        Attributes.setAttributesLabel(label: self.labelEmail, labelText: "INFORME SUA CONTA DE E-MAIL", size: 16, fontFamily: "Dosis-Bold", spaceLine: 3.0, textColor: textColor)
        self.stackInvalidEmail.isHidden = true
    }
    
    
    func goToNextScreen(textFieldEmail : UITextField, button: UIButton, loading: UIActivityIndicatorView, completion: @escaping(String?) -> Void) {
        guard let email = textFieldEmail.text else { return }
        if ValidateForm.checkEmail(email) {
            Attributes.setInicialAttributes(textField: textFieldEmail, stackView: stackInvalidEmail)
            APIManager.shared.getUserWithEmail(email, completion: { (user: UsersInfo?) in
                if user?.registrationStatus == "INEXISTENT" {
                    //email não existe
                    completion("INEXISTENT")
                }
        else if user?.registrationStatus == "PENDING" {
                    //email existe e cadastro está incompleto
                    completion("PENDING")
                    
                } else if user?.registrationStatus == "REGISTERED" {
                    //email existe e cadastro está completo
                    completion("REGISTERED")
                    
                }

            })
        } else {
            showLoading(status: false, button: button, loading: loading)
            Attributes.setAttributeInvalidField(textField: textFieldEmail, stackView: stackInvalidEmail)
        }
    }
    
    func showLoading(status: Bool, button: UIButton, loading: UIActivityIndicatorView)
    {
        ValidateForm.showLoading(status: status, button: button, loading: loading)
    }

}

