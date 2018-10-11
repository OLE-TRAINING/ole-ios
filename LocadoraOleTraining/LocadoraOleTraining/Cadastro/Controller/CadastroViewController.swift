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
    
    @IBOutlet weak var stackViewNomeCompleto: UIStackView!
    @IBOutlet weak var stackViewNomeUsuario: UIStackView!
    @IBOutlet weak var stackViewSenha: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textColor = UIColor(red: 0.357, green: 0.353, blue: 0.353, alpha: 1)
        Atributos.setaAtributosLabel(label: LabelTitulo, labelText: "CRIE SUA NOVA\nCONTA", size: 16, fontFamily: "Dosis-Bold", spaceLine: 3.0, textColor: textColor)
        Atributos.setaAtributosLabel(label: LabelEmail, labelText: "lorena@gmail.com", size: 12.5, fontFamily: "Roboto-Regular", spaceLine: 0.6, textColor: textColor)
        Atributos.setaAtributosButton(button: ButtonAvancar)
        
        stackViewNomeCompleto.isHidden = true
        stackViewNomeUsuario.isHidden = true
        stackViewSenha.isHidden = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    

    @IBAction func ButtonAvancar(_ sender: UIButton) {
        if !ValidaFormulario.verificaTextFieldsPreenchidos(textFields: CamposTextField) {
            ValidaFormulario.showAlertSucessoNoPreenchimento()
        }
        
    }
    
    

}
