//
//  ViewModel.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 23/10/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import Foundation
import UIKit

class ViewModel {
    
    var labelEmail = UILabel()
    var stackInvalidEmail = UIStackView()
    var email: String?
    
    init() {
        
    }
    
    
    func startAplication(labelEmail: UILabel, stackInvalidEmail: UIStackView) {
        self.labelEmail = labelEmail
        self.stackInvalidEmail = stackInvalidEmail
        
        let textColor = UIColor(red: 0.357, green: 0.353, blue: 0.353, alpha: 1)
        Attributes.setAttributesLabel(label: self.labelEmail, labelText: "INFORME SUA CONTA DE E-MAIL", size: 16, fontFamily: "Dosis-Bold", spaceLine: 3.0, textColor: textColor)
        stackInvalidEmail.isHidden = true
    }
    
    func goToNextScreen(textFieldEmail: UITextField) {
        
//        guard let email = textFieldEmail.text else { return }
//        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else { return }
//        if ValidateForm.checkEmail(email) {
//            Attributes.setInicialAttributes(textField: textFieldEmail, stackView: stackInvalidEmail)
//            APIManager.shared.getUserWithEmail(email, completion: { [weak self] (user: UsersInfo?) in
//                if user?.registrationStatus == "UNEXISTENT" {
//                    //email não existe
//                    viewController.goToRegistrationScreen()
//                } else if user?.registrationStatus == "PENDING" {
//                    //email existe e cadastro está incompleto
//                    
//                    self?.goToContinueRegistrationScreen()
//                    
//                } else if user?.registrationStatus == "REGISTERED" {
//                    //email existe e cadastro está completo
//                    self?.goToLoginScreen()
//                    
//                } else {
//                    ValidateForm.showAlertError()
//                }
//            })
//        } else {
//            Attributes.setAttributeInvalidField(textField: textFieldEmail, stackView: stackInvalidEmail)
//        }
    }
    
}

//extension ViewModel {
//    
//    func goToRegistrationScreen() {
//        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else { return }
//        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "cadastro") as! NewRegistrationViewController
//        if let email = email {
//            controller.emailUser = email
//        }
//        viewController.navigationController?.pushViewController(controller, animated: true)
//    }
//    
//    func goToLoginScreen() {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "login") as! LoginViewController
//        if let email = email {
//            controller.emailUser = email
//        }
//        
//        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else { return }
//        viewController.self.navigationController?.pushViewController(controller, animated: true)
//    }
//    
//    func goToContinueRegistrationScreen() {
//        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else { return }
//        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "continuarCadastro") as! ContinueRegistration
//        if let email = email {
//            controller.emailUser = email
//        }
//        viewController.navigationController?.pushViewController(controller, animated: true)
//    }
//}

