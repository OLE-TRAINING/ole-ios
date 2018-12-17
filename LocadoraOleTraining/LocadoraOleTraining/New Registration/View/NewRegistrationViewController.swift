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
    @IBOutlet weak var loadingGo: UIActivityIndicatorView!
    
    @IBOutlet var textFields: [UITextField]!
    
    @IBOutlet weak var textFieldFullName: UITextField!
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var msgUsername: UILabel!
    
    @IBOutlet weak var stackViewFullName: UIStackView!
    @IBOutlet weak var stackViewUsername: UIStackView!
    @IBOutlet weak var stackViewPassword: UIStackView!
    
    var resultFullName = false
    var resultUsername = false
    var resultPassword = false

    var emailUser: String?
    var newRegistrationViewModel = NewRegistrationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRegistrationViewModel.startRegistration(emailUser: emailUser, labelTitle: labelTitle, labelEmail: labelEmail, stackViewFullName: stackViewFullName, stackViewUsername: stackViewUsername, stackViewPassword: stackViewPassword)
        newRegistrationViewModel.disableButton(button: buttonGo)
        textFieldFullName.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        textFieldUsername.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        textFieldPassword.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        newRegistrationViewModel.showLoading(status: false, button: buttonGo, loading: loadingGo)
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == textFieldFullName {
            resultFullName = newRegistrationViewModel.checkFullName(textFieldFullName: textFieldFullName)
        }
        if textField == textFieldUsername {
            resultUsername = newRegistrationViewModel.checkUsername(textFieldUsername: textFieldUsername, msgUsername: msgUsername)
        }
        
        if textField == textFieldPassword {
            resultPassword = newRegistrationViewModel.checkPassword(textFieldPassword: textFieldPassword)
        }
        
        if resultFullName && resultUsername && resultPassword {
            newRegistrationViewModel.enableButton(button: buttonGo)
        } else {
            newRegistrationViewModel.disableButton(button: buttonGo)
        }
    }
    
    
    @IBAction func ButtonGo(_ sender: UIButton) {
        newRegistrationViewModel.showLoading(status: true, button: buttonGo, loading: loadingGo)
        newRegistrationViewModel.goToNextScreen(msgUsername: msgUsername, button: buttonGo, loading: loadingGo, textFieldFullName: textFieldFullName, textFieldUsername: textFieldUsername, textFieldPassword: textFieldPassword) { (result: Bool?) in
            guard let flag = result else { return }
            if flag {
                self.goToValidateTokenScreen()
            } else {
                self.newRegistrationViewModel.showLoading(status: false, button: self.buttonGo, loading: self.loadingGo)
                
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
