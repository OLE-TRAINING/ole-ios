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
    
    let flagAux = 3 //1 = email não existe; 2 = email existe e cadastro está completo; 3 = email existe e cadastro está incompleto;
    
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
            Atributos.setaAtributosIniciais(textField: TextFieldEmail, stackView: stackEmailInvalido)
            if flagAux == 1 {
                //email não existe
                vaiParaTelaCadastro()
                
            } else if flagAux == 2 {
                //email existe e cadastro já está completo
                vaiParaTelaLogin()

            } else if flagAux == 3 {
                //email existe e cadastro não está completo
                vaiParaTelaContinuarCadastro()
            }
            
        } else {
            Atributos.setaAtributosCampoInvalido(textField: TextFieldEmail, stackView: stackEmailInvalido)
        }
        
    }
}



extension ViewController {

    func vaiParaTelaCadastro() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "cadastro") as! CadastroViewController
        if let email = TextFieldEmail.text {
            controller.emailUsuario = email
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func vaiParaTelaLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "login") as! LoginViewController
        if let email = TextFieldEmail.text {
            controller.emailUsuario = email
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func vaiParaTelaContinuarCadastro() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "continuarCadastro") as! ContinuarCadastroViewController
        if let email = TextFieldEmail.text {
            controller.emailUsuario = email
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
}




