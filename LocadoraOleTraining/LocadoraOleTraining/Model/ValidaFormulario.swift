//
//  ValidaFormulario.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 11/10/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

class ValidaFormulario: NSObject {

    static let shared = ValidaFormulario()
    private override init() {}
    
    // MARK:-  STATIC METHODS
    
    static func verificaEmail(_ email: String) -> Bool {
        return shared.verificaEmail(email)
    }
    
    static func showAlertSucessoNoPreenchimento() {
        return shared.showAlertSucessoNoPreenchimento()
    }
    
    static func showAlertFalhaNoPreenchimento() {
        return shared.showAlertFalhaNoPreenchimento()
    }
    
    static func verificaTextFieldsPreenchidos(textFields: [UITextField]) -> Bool {
        return shared.verificaTextFieldsPreenchidos(textFields: textFields)
    }
    
    
    
    // MARK:-  IMPLEMENTATION OF STATIC METHODS
    
    func verificaEmail(_ email: String) -> Bool {
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format: "SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func showAlertSucessoNoPreenchimento() {
        
        let alertController = UIAlertController(title: "Atenção", message: "Preencha corretamente os campos.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
        }
        
        alertController.addAction(okAction)
        
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertFalhaNoPreenchimento() {
        let alertController = UIAlertController(title: "Sucesso", message: "Campos preenchidos corretamente", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
        }
        
        alertController.addAction(okAction)
        
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    
    func verificaTextFieldsPreenchidos(textFields: [UITextField]) -> Bool {
        var textFieldsPreenchidos = true
        
        for textField in textFields {
            if textField.text == "" {
                textFieldsPreenchidos = false
                break
            } else{
                textFieldsPreenchidos = true
            }
        }
        
        return textFieldsPreenchidos
    }
    
    
    
}
