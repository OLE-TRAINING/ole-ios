//
//  ViewController.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 10/10/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

class PreLoginViewController: UIViewController {

    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var buttonGo: UIButton!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var stackInvalidEmail: UIStackView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var preLoginViewModel = PreLoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preLoginViewModel.startAplication(labelEmail: labelEmail, stackInvalidEmail: stackInvalidEmail)
        preLoginViewModel.disableButton(buttonGo: buttonGo)
        textFieldEmail.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        preLoginViewModel.showLoading(status: false, button: buttonGo, loading: loading)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        tryEmail()
    }
    
    func tryEmail() {
        PreLoginViewController.cancelPreviousPerformRequests(withTarget: self)
        self.perform(#selector(checkEmail), with: nil, afterDelay: 1.0)
    }
    
    @objc func checkEmail() {
        preLoginViewModel.checkEmail(textFieldEmail: textFieldEmail, buttonGo: buttonGo)
    }
    
    @IBAction func buttonGo(_ sender: UIButton) {
        preLoginViewModel.showLoading(status: true, button: buttonGo, loading: loading)
        preLoginViewModel.goToNextScreen(textFieldEmail: textFieldEmail, button: buttonGo, loading: loading, completion: { (result: String?) in
            if result == "INEXISTENT" {
                //email não existe
                self.goToRegistrationScreen()
            } else if result == "PENDING" {
                //email existe e cadastro está incompleto
                self.goToContinueRegistrationScreen()
                
            } else if result == "REGISTERED" {
                //email existe e cadastro está completo
                self.goToLoginScreen()
                
            }
            else {
                self.preLoginViewModel.showLoading(status: false, button: self.buttonGo, loading: self.loading)
            }
        })
    }
    

}



extension PreLoginViewController {

    func goToRegistrationScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "cadastro") as! NewRegistrationViewController
        if let email = textFieldEmail.text {
            controller.emailUser = email
        }
        self.navigationController?.pushViewController(controller, animated: false)
    }


    func goToLoginScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "login") as! LoginViewController
        if let email = textFieldEmail.text {
            controller.emailUser = email
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func goToContinueRegistrationScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "continuarCadastro") as! ContinueRegistration
        if let email = textFieldEmail.text {
            controller.emailUser = email
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
}




