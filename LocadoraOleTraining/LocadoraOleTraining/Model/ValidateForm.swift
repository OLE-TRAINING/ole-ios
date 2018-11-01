//
//  ValidaFormulario.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 11/10/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit



class ValidateForm: NSObject {

    static let shared = ValidateForm()
    private override init() {}
    
    // MARK:-  STATIC METHODS
    
    static func checkEmail(_ email: String) -> Bool {
        return shared.checkEmail(email)
    }
    
    static func showAlertSucess() {
        return shared.showAlertSucess()
    }
    
    static func showAlertFailure() {
        return shared.showAlertFailure()
    }
    static func showAlertError() {
        return shared.showAlertError()
    }
    
    
    static func checkFilledTextFields(textFieldName: UITextField, textFieldUsername: UITextField, textFieldPassword: UITextField) -> Bool {
        return shared.checkFilledTextFields(textFieldName: textFieldName, textFieldUsername: textFieldUsername, textFieldPassword: textFieldPassword)
    }
    
    static func checkFullName(fullName: String) -> Bool {
        return shared.checkFullName(fullName: fullName)
    }
    
    static func checkUsername(username: String) -> Bool {
        return shared.checkUsername(username: username)
    }
    
    static func checkPassword(password: String) -> Bool {
        return shared.checkPassword(password: password)
    }
    
    static func checkCode(_ code: String) -> Bool {
        return shared.checkCode(code)
    }
    
    static func showLoading(status: Bool, button: UIButton, loading: UIActivityIndicatorView) {
        return shared.showLoading(status, button: button, loading: loading)
    }
    

    
    
    // MARK:-  IMPLEMENTATION OF STATIC METHODS
    
    func checkEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let emailTest = NSPredicate(format: "SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func checkFullName(fullName: String) -> Bool {
        let nameRegEx = "^[a-zA-Z ]{2,50}$" //nome com espaços

        let testName = NSPredicate(format: "SELF MATCHES[c] %@", nameRegEx)
        return testName.evaluate(with: fullName)
        
    }
    
    func checkUsername(username: String) -> Bool {
        let usernameRegEx = "^[a-zA-Z0-9]{1,15}$" //nome de usuario com letras maiúsculas, minúsculas e numeros sem espaços
        
        let testUsername = NSPredicate(format: "SELF MATCHES[c] %@", usernameRegEx)
        return testUsername.evaluate(with: username)
    }
    
    func checkPassword(password: String) -> Bool {
        let passwordRegEx = "(?!^[0-9]*$)(?!^[a-zA-Z]*$)^([a-zA-Z0-9]{6,15})$" // Password length 6-15
        
        let testPassword = NSPredicate(format: "SELF MATCHES[c] %@", passwordRegEx)
        return testPassword.evaluate(with: password)
    }
    
    func checkCode(_ codigo: String) -> Bool {
        let codeRegEx = "^.{5,15}$" // Codigo length 6-15
        
        let testCode = NSPredicate(format: "SELF MATCHES[c] %@", codeRegEx)
        return testCode.evaluate(with: codigo)
    }
    
    func showAlertSucess() {
        let alertController = UIAlertController(title: "Sucesso", message: "Campos preenchidos corretamente", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
        }
        
        alertController.addAction(okAction)
        
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertFailure() {
        let alertController = UIAlertController(title: "Atenção", message: "Preencha corretamente os campos.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
        }
        
        alertController.addAction(okAction)
        
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertError() {
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        
        let alertController = UIAlertController(title: "Ops..", message: "Ocorreu um erro inesperado, por favor tente novamente.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tentar novamente", style: UIAlertActionStyle.default) {
            UIAlertAction in
                viewController.viewWillAppear(false)
        }
        
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
        viewController.viewWillAppear(false)
    }
    
    func showLoading(_ status: Bool, button: UIButton, loading: UIActivityIndicatorView) {
        if status {
            loading.isHidden = false
            button.isHidden = true
            loading.startAnimating()
        } else {
            loading.isHidden = true
            button.isHidden = false
        }
    }
    
    
    func checkFilledTextFields(textFieldName: UITextField, textFieldUsername: UITextField, textFieldPassword: UITextField) -> Bool {

       var filledTextFields = true

        if !checkFullName(fullName: textFieldName.text ?? "") || !checkUsername(username: textFieldUsername.text ?? "") || !checkPassword(password: textFieldPassword.text ?? ""){
            filledTextFields = false
        } else{
            filledTextFields = true
        }
        
        return filledTextFields
        
    }
    

    
}
