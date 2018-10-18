//
//  ValidaFormulario.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 11/10/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

enum TiposDeTextField: Int {
    case nomeCompleto = 1
    case nomeUsuario = 2
    case senha = 3
}


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
    
    static func verificaTextFieldsPreenchidos(textFieldNome: UITextField, textFieldNomeUsuario: UITextField, textFieldSenha: UITextField) -> Bool {
        return shared.verificaTextFieldsPreenchidos(textFieldNome: textFieldNome, textFieldNomeUsuario: textFieldNomeUsuario, textFieldSenha: textFieldSenha)
    }
    
    static func verificaNomeCompleto(nomeCompleto: String) -> Bool {
        return shared.verificaNomeCompleto(nomeCompleto: nomeCompleto)
    }
    
    static func verificaNomeUsuario(nomeUsuario: String) -> Bool {
        return shared.verificaNomeUsuario(nomeUsuario: nomeUsuario)
    }
    
    static func verificaSenha(senha: String) -> Bool {
        return shared.verificaSenha(senha: senha)
    }
    
    static func verificaCodigo(_ codigo: String) -> Bool {
        return shared.verificaCodigo(codigo)
    }
    
    
    
    // MARK:-  IMPLEMENTATION OF STATIC METHODS
    
    func verificaEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let emailTest = NSPredicate(format: "SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func verificaNomeCompleto(nomeCompleto: String) -> Bool {
        let nomeRegEx = "^[A-Z]+[a-zA-Z ]+.{3,50}$" //nome com espaços e primeira letra maiuscula

        let nomeTest = NSPredicate(format: "SELF MATCHES[c] %@", nomeRegEx)
        return nomeTest.evaluate(with: nomeCompleto)
        
    }
    
    func verificaNomeUsuario(nomeUsuario: String) -> Bool {
        let nomeUsuarioRegEx = "^[a-zA-Z0-9]+.{1,15}$" //nome de usuario com letras maiúsculas, minúsculas e numeros sem espaços
        
        let nomeUsuarioTest = NSPredicate(format: "SELF MATCHES[c] %@", nomeUsuarioRegEx)
        return nomeUsuarioTest.evaluate(with: nomeUsuario)
    }
    
    func verificaSenha(senha: String) -> Bool {
        let senhaRegEx = "^[a-zA-Z0-9]+.{6,15}$" // Password length 6-15
        
        let senhaTest = NSPredicate(format: "SELF MATCHES[c] %@", senhaRegEx)
        return senhaTest.evaluate(with: senha)
    }
    
    func verificaCodigo(_ codigo: String) -> Bool {
        let codigoRegEx = "^.{6,15}$" // Codigo length 6-15
        
        let codigoTest = NSPredicate(format: "SELF MATCHES[c] %@", codigoRegEx)
        return codigoTest.evaluate(with: codigo)
    }
    
    func showAlertSucessoNoPreenchimento() {
        let alertController = UIAlertController(title: "Sucesso", message: "Campos preenchidos corretamente", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
        }
        
        alertController.addAction(okAction)
        
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertFalhaNoPreenchimento() {
        let alertController = UIAlertController(title: "Atenção", message: "Preencha corretamente os campos.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
        }
        
        alertController.addAction(okAction)
        
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    func verificaTextFieldsPreenchidos(textFieldNome: UITextField, textFieldNomeUsuario: UITextField, textFieldSenha: UITextField) -> Bool {

       var textFieldsPreenchidos = true

        if !verificaNomeCompleto(nomeCompleto: textFieldNome.text ?? "") || !verificaNomeUsuario(nomeUsuario: textFieldNomeUsuario.text ?? "") || !verificaSenha(senha: textFieldSenha.text ?? ""){
            textFieldsPreenchidos = false
        } else{
            textFieldsPreenchidos = true
        }
        
        return textFieldsPreenchidos
        
    }
    
    
    
    
    
    
    
}
