//
//  ValidarTokenViewController.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 16/10/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

class ValidarTokenViewController: UIViewController {

    @IBOutlet weak var LabelTitulo: UILabel!
    @IBOutlet weak var LabelEmail: UILabel!
    @IBOutlet weak var TextFieldCodigo: UITextField!
    @IBOutlet weak var LabelNaoRecebeu: UILabel!
    @IBOutlet weak var ButtonEnviar: UIButton!
    @IBOutlet weak var stackViewCodigoInvalido: UIStackView!
    @IBOutlet weak var ButtonValidar: UIButton!
    
    var emailUsuario: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textColor = UIColor(red: 0.357, green: 0.353, blue: 0.353, alpha: 1)
        Atributos.setaAtributosLabel(label: LabelTitulo, labelText: "PARA SUA SEGURANÇA, INFORME O CÓDIGO ENVIADO PARA O SEU\nE-MAIL:", size: 16, fontFamily: "Dosis-Bold", spaceLine: 3.0, textColor: textColor)
        let emailColor = UIColor(red: 0.99, green: 0.098, blue: 0.141, alpha: 1)
        if let email = emailUsuario {
             Atributos.setaAtributosLabel(label: LabelEmail, labelText: email, size: 12, fontFamily: "Roboto-Bold", spaceLine: 0.6, textColor: emailColor)
        }
       
        Atributos.setaAtributosLabel(label: LabelNaoRecebeu, labelText: "Não recebeu o código?", size: 12, fontFamily: "Roboto-Regular", spaceLine: 0.5, textColor: textColor)
        
        Atributos.setaAtributosButton(button: ButtonValidar)
        
        stackViewCodigoInvalido.isHidden = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func ButtonVoltar(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ButtonValidar(_ sender: UIButton) {
        guard let codigo = TextFieldCodigo.text else { return }
        if ValidaFormulario.verificaCodigo(codigo) {
            vaiParaTelaLogin()
            Atributos.setaAtributosIniciais(textField: TextFieldCodigo, stackView: stackViewCodigoInvalido)
        } else {
            Atributos.setaAtributosCampoInvalido(textField: TextFieldCodigo, stackView: stackViewCodigoInvalido)
        }
    }
    
}

extension ValidarTokenViewController {
    func vaiParaTelaLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "login") as! LoginViewController
        if let email = LabelEmail.text {
            controller.emailUsuario = email
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
