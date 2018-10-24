//
//  ViewController.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 10/10/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var buttonGo: UIButton!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var stackInvalidEmail: UIStackView!
    
    var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.startAplication(labelEmail: labelEmail, stackInvalidEmail: stackInvalidEmail)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "RegistrationSegue" {
            
            if let registrationViewController = segue.destination as? NewRegistrationViewController
            {
                
                registrationViewController.emailUser = viewModel.email
            }
        }
        
    }
    

    
    @IBAction func buttonGo(_ sender: UIButton) {
        
        viewModel.goToNextScreen(textFieldEmail: textFieldEmail, completion: { [weak self] (result: String?) in
            if result == "INEXISTENT" {
                //email não existe
                self?.goToRegistrationScreen()
            } else if result == "PENDING" {
                //email existe e cadastro está incompleto
                self?.goToContinueRegistrationScreen()
                
            } else if result == "REGISTERED" {
                //email existe e cadastro está completo
                self?.goToLoginScreen()
                
            }
        })
    }

}



extension ViewController {

    func goToRegistrationScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "cadastro") as! NewRegistrationViewController
        if let email = textFieldEmail.text {
            controller.emailUser = email
        }
        self.navigationController?.pushViewController(controller, animated: true)
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




