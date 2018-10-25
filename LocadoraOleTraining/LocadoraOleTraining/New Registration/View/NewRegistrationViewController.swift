//
//  CadastroViewController.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 11/10/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

class NewRegistrationViewController: UIViewController {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var buttonGo: UIButton!
    
    @IBOutlet var textFields: [UITextField]!
    
    @IBOutlet weak var textFieldFullName: UITextField!
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    @IBOutlet weak var stackViewFullName: UIStackView!
    @IBOutlet weak var stackViewUsername: UIStackView!
    @IBOutlet weak var stackViewPassword: UIStackView!
    
    

//    let borderColor = UIColor(red: 0.99, green: 0.098, blue: 0.141, alpha: 1)
    
    var emailUser: String?
    var newRegistrationViewModel = NewRegistrationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRegistrationViewModel.startRegistration(emailUser: emailUser, labelTitle: labelTitle, labelEmail: labelEmail, stackViewFullName: stackViewFullName, stackViewUsername: stackViewUsername, stackViewPassword: stackViewPassword)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func ButtonGo(_ sender: UIButton) {
        
        newRegistrationViewModel.goToNextScreen(textFieldFullName: textFieldFullName, textFieldUsername: textFieldUsername, textFieldPassword: textFieldPassword) { (result: Bool?) in
            if let _ = result {
                self.goToValidateTokenScreen()
            }
        }
        
    }
    
}

extension NewRegistrationViewController {
    func goToValidateTokenScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "validarToken") as! ValidateTokenViewController
        if let email = labelEmail.text {
            controller.emailUser = email
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
