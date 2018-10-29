//
//  ContinuarCadastroViewController.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 15/10/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

class ContinueRegistration: UIViewController {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var textFieldCode: UITextField!
    @IBOutlet weak var labelDidNotReceive: UILabel!
    @IBOutlet weak var buttonSend: UIButton!
    @IBOutlet weak var buttonValidate: UIButton!
    @IBOutlet weak var stackInvalidCode: UIStackView!
    @IBOutlet weak var loadingValidate: UIActivityIndicatorView!
    @IBOutlet weak var loadingSendAgain: UIActivityIndicatorView!
    
    var emailUser: String?
    var continueRegistrationViewModel = ContinueRegistrationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        continueRegistrationViewModel.continueRegistration(labelDidNotReceive: labelDidNotReceive, emailUser: emailUser, labelTitle: labelTitle, labelEmail: labelEmail, stackInvalidCode: stackInvalidCode)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        continueRegistrationViewModel.showLoading(status: false, button: buttonSend, loading: loadingSendAgain)
        continueRegistrationViewModel.showLoading(status: false, button: buttonValidate, loading: loadingValidate)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonValidate(_ sender: UIButton) {
        continueRegistrationViewModel.showLoading(status: true, button: buttonValidate, loading: loadingValidate)
        continueRegistrationViewModel.validateToken(textFieldCode: textFieldCode, button: buttonValidate, loading: loadingValidate, completion: { (response: Bool) in
            if response {
                self.goToLoginScreen()
            }
        })


    }
    
    @IBAction func buttonSend(_ sender: UIButton) {
        continueRegistrationViewModel.showLoading(status: true, button: buttonSend, loading: loadingSendAgain)
        continueRegistrationViewModel.resendToken()
    }
    
}

extension ContinueRegistration {
    func goToLoginScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "login") as! LoginViewController
        if let email = labelEmail.text {
            controller.emailUser = email
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
