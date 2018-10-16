//
//  CadastroViewController.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 11/10/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

class CadastroViewController: UIViewController {

    @IBOutlet weak var LabelTitulo: UILabel!
    @IBOutlet weak var LabelEmail: UILabel!
    @IBOutlet weak var ButtonAvancar: UIButton!
    
    @IBOutlet var CamposTextField: [UITextField]!
    
    @IBOutlet weak var TextFieldNomeCompleto: UITextField!
    @IBOutlet weak var TextFieldNomeUsuario: UITextField!
    @IBOutlet weak var TextFieldSenha: UITextField!
    
    @IBOutlet weak var stackViewNomeCompleto: UIStackView!
    @IBOutlet weak var stackViewNomeUsuario: UIStackView!
    @IBOutlet weak var stackViewSenha: UIStackView!
    
    
    let textColor = UIColor(red: 0.357, green: 0.353, blue: 0.353, alpha: 1)
    let borderColor = UIColor(red: 0.99, green: 0.098, blue: 0.141, alpha: 1)
    
    var emailUsuario: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Atributos.setaAtributosLabel(label: LabelTitulo, labelText: "CRIE SUA NOVA\nCONTA", size: 16, fontFamily: "Dosis-Bold", spaceLine: 3.0, textColor: textColor)
        
        if let email = emailUsuario {
            Atributos.setaAtributosLabel(label: LabelEmail, labelText: email, size: 12.5, fontFamily: "Roboto-Regular", spaceLine: 0.6, textColor: textColor)
        }
        
        Atributos.setaAtributosButton(button: ButtonAvancar)
        
        stackViewNomeCompleto.isHidden = true
        stackViewNomeUsuario.isHidden = true
        stackViewSenha.isHidden = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func ButtonVoltar(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func ButtonAvancar(_ sender: UIButton) {
        
        if ValidaFormulario.verificaTextFieldsPreenchidos(textFieldNome: TextFieldNomeCompleto, textFieldNomeUsuario: TextFieldNomeUsuario, textFieldSenha: TextFieldSenha){
            
            Atributos.setaAtributosIniciais(textField: TextFieldNomeCompleto, stackView: stackViewNomeCompleto)
            Atributos.setaAtributosIniciais(textField: TextFieldNomeUsuario, stackView: stackViewNomeUsuario)
            Atributos.setaAtributosIniciais(textField: TextFieldSenha, stackView: stackViewSenha)
            
            vaiParaTelaValidarToken()

        } else {
            switch ValidaFormulario.verificaNomeCompleto(nomeCompleto: TextFieldNomeCompleto.text ?? "") {
            case true:
                Atributos.setaAtributosIniciais(textField: TextFieldNomeCompleto, stackView: stackViewNomeCompleto)
            case false:
                Atributos.setaAtributosCampoInvalido(textField: TextFieldNomeCompleto, stackView: stackViewNomeCompleto)
            }
            
            switch ValidaFormulario.verificaNomeUsuario(nomeUsuario: TextFieldNomeUsuario.text ?? "") {
            case true:
                Atributos.setaAtributosIniciais(textField: TextFieldNomeUsuario, stackView: stackViewNomeUsuario)
            case false:
                Atributos.setaAtributosCampoInvalido(textField: TextFieldNomeUsuario, stackView: stackViewNomeUsuario)
                
            }
            
            switch ValidaFormulario.verificaSenha(senha: TextFieldSenha.text ?? "") {
            case true:
                Atributos.setaAtributosIniciais(textField: TextFieldSenha, stackView: stackViewSenha)
            case false:
                Atributos.setaAtributosCampoInvalido(textField: TextFieldSenha, stackView: stackViewSenha)
            }
            
        }
        
    }
    
}

extension CadastroViewController {
    func vaiParaTelaValidarToken() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "validarToken") as! ValidarTokenViewController
        if let email = LabelEmail.text {
            controller.emailUsuario = email
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
