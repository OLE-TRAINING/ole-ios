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
    @IBOutlet weak var textFieldToken: UITextField!
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
        continueRegistrationViewModel.disableButton(button: buttonValidate)
        textFieldToken.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        continueRegistrationViewModel.showLoading(status: false, button: buttonSend, loading: loadingSendAgain)
        continueRegistrationViewModel.showLoading(status: false, button: buttonValidate, loading: loadingValidate)
    }

    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonValidate(_ sender: UIButton) {
        continueRegistrationViewModel.showLoading(status: true, button: buttonValidate, loading: loadingValidate)
        continueRegistrationViewModel.validateToken(textFieldToken: textFieldToken, button: buttonValidate, loading: loadingValidate, completion: { (response: Bool) in
            if response {
                self.goToLoginScreen()
            } else {
                self.continueRegistrationViewModel.showLoading(status: false, button: self.buttonValidate, loading: self.loadingValidate)
            }
        })


    }
    
    @objc func textFieldDidEndEditing(_ textField: UITextField)  {
        if continueRegistrationViewModel.checkToken(textFieldToken: textFieldToken) {
            continueRegistrationViewModel.enableButton(button: buttonValidate)
        } else {
            continueRegistrationViewModel.disableButton(button: buttonValidate)
        }
    }
    
    @IBAction func buttonSend(_ sender: UIButton) {
        continueRegistrationViewModel.showLoading(status: true, button: buttonSend, loading: loadingSendAgain)
        continueRegistrationViewModel.resendToken(completion: {(result) in
            if result {
                self.viewWillAppear(true)
            }
        })
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
