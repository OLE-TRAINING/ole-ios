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
    
    @IBOutlet weak var stackViewFullName: UIStackView!
    @IBOutlet weak var stackViewUsername: UIStackView!
    @IBOutlet weak var stackViewPassword: UIStackView!
    
    

    
    var emailUser: String?
    var newRegistrationViewModel = NewRegistrationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRegistrationViewModel.startRegistration(emailUser: emailUser, labelTitle: labelTitle, labelEmail: labelEmail, stackViewFullName: stackViewFullName, stackViewUsername: stackViewUsername, stackViewPassword: stackViewPassword)
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        newRegistrationViewModel.showLoading(status: false, button: buttonGo, loading: loadingGo)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func ButtonGo(_ sender: UIButton) {
        newRegistrationViewModel.showLoading(status: true, button: buttonGo, loading: loadingGo)
        newRegistrationViewModel.goToNextScreen(button: buttonGo, loading: loadingGo, textFieldFullName: textFieldFullName, textFieldUsername: textFieldUsername, textFieldPassword: textFieldPassword) { (result: Bool?) in
            if let _ = result {
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
