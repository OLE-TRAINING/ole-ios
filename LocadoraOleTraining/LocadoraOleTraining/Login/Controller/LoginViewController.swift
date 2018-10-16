//
//  LoginViewController.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 16/10/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var LabelTitulo: UILabel!
    @IBOutlet weak var LabelEmail: UILabel!
    @IBOutlet weak var TextFieldSenha: UITextField!
    @IBOutlet weak var ButtonEsqueceuSenha: UIButton!
    @IBOutlet weak var ButtonEntrar: UIButton!
    @IBOutlet weak var ViewDadosInvalidos: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textColor = UIColor(red: 0.357, green: 0.353, blue: 0.353, alpha: 1)
        Atributos.setaAtributosLabel(label: LabelTitulo, labelText: "INFORME SUA SENHA:", size: 16, fontFamily: "Dosis-Bold", spaceLine: 3.0, textColor: textColor)
        Atributos.setaAtributosLabel(label: LabelEmail, labelText: "lorena@gmail.com", size: 12, fontFamily: "Arial", spaceLine: 0.6, textColor: textColor)
        Atributos.setaAtributosButton(button: ButtonEntrar)
        ViewDadosInvalidos.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ButtonEntrar(_ sender: UIButton) {
        guard let senha = TextFieldSenha.text else { return }
        if ValidaFormulario.verificaSenha(senha: senha) {
            ValidaFormulario.showAlertSucessoNoPreenchimento()
            ViewDadosInvalidos.isHidden = true
        } else {
            ViewDadosInvalidos.isHidden = false
        }

    }
    

}
