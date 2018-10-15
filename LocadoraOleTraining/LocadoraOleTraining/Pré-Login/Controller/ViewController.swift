//
//  ViewController.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 10/10/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var LabelEmail: UILabel!
    @IBOutlet weak var ButtonAvancar: UIButton!
    @IBOutlet weak var TextFieldEmail: UITextField!
    @IBOutlet weak var stackEmailInvalido: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textColor = UIColor(red: 0.357, green: 0.353, blue: 0.353, alpha: 1)
        Atributos.setaAtributosLabel(label: LabelEmail, labelText: "INFORME SUA CONTA DE E-MAIL", size: 16, fontFamily: "Dosis-Bold", spaceLine: 3.0, textColor: textColor)
        Atributos.setaAtributosButton(button: ButtonAvancar)
        stackEmailInvalido.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func buttonAvancar(_ sender: UIButton) {

        guard let email = TextFieldEmail.text else { return }
        if ValidaFormulario.verificaEmail(email) {
            stackEmailInvalido.isHidden = true
            ValidaFormulario.showAlertSucessoNoPreenchimento()
        } else {
            stackEmailInvalido.isHidden = false
        }
        
    }
}





