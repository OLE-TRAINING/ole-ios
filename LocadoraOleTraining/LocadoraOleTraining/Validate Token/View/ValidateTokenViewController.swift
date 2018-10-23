//
//  ValidarTokenViewController.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 16/10/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

class ValidateTokenViewController: UIViewController {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var textFieldCode: UITextField!
    @IBOutlet weak var labelDidNotReceive: UILabel!
    @IBOutlet weak var buttonSend: UIButton!
    @IBOutlet weak var stackViewInvalidCode: UIStackView!
    @IBOutlet weak var buttonValidate: UIButton!
    
    var emailUser: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textColor = UIColor(red: 0.357, green: 0.353, blue: 0.353, alpha: 1)
        Attributes.setAttributesLabel(label: labelTitle, labelText: "PARA SUA SEGURANÇA, INFORME O CÓDIGO ENVIADO PARA O SEU\nE-MAIL:", size: 16, fontFamily: "Dosis-Bold", spaceLine: 3.0, textColor: textColor)
        let emailColor = UIColor(red: 0.99, green: 0.098, blue: 0.141, alpha: 1)
        if let email = emailUser {
             Attributes.setAttributesLabel(label: labelEmail, labelText: email, size: 12, fontFamily: "Roboto-Bold", spaceLine: 0.6, textColor: emailColor)
        }
       
        Attributes.setAttributesLabel(label: labelDidNotReceive, labelText: "Não recebeu o código?", size: 12, fontFamily: "Roboto-Regular", spaceLine: 0.5, textColor: textColor)
        
        stackViewInvalidCode.isHidden = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonValidate(_ sender: UIButton) {
        guard let code = textFieldCode.text else { return }
        if ValidateForm.checkCode(code) {
            guard let email = labelEmail.text else { return }
//            APIManager.shared.getUserWithEmail(email, completion: {(user: NewUsers?) in
//                APIManager.shared.updateRegistrationStatus(email: (user?.email)!, password: (user?.password)!, completeName: (user?.completeName)!, username: (user?.username)!, registrationStatus: "REGISTERED" )
//            })
            goToLoginScreen()
            Attributes.setInicialAttributes(textField: textFieldCode, stackView: stackViewInvalidCode)
        } else {
            Attributes.setAttributeInvalidField(textField: textFieldCode, stackView: stackViewInvalidCode)
        }
    }
    
}

extension ValidateTokenViewController {
    func goToLoginScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "login") as! LoginViewController
        if let email = labelEmail.text {
            controller.emailUser = email
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
