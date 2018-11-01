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
    @IBOutlet weak var buttonSendAgain: UIButton!
    @IBOutlet weak var buttonValidate: UIButton!
    @IBOutlet weak var stackInvalidCode: UIStackView!
    @IBOutlet weak var loadingSendAgain: UIActivityIndicatorView!
    @IBOutlet weak var loadingValidate: UIActivityIndicatorView!
    
    var emailUser = String()
    let validateTokenViewModel = ValidateTokenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        validateTokenViewModel.startValidateToken(labelDidNotReceive: labelDidNotReceive, emailUser: emailUser, labelTitle: labelTitle, labelEmail: labelEmail, stackViewInvalidCode: stackInvalidCode)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        validateTokenViewModel.showLoading(status: false, button: buttonSendAgain, loading: loadingSendAgain )
        validateTokenViewModel.showLoading(status: false, button: buttonValidate, loading: loadingValidate)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonValidate(_ sender: UIButton) {
        validateTokenViewModel.showLoading(status: true, button: buttonValidate, loading: loadingValidate)
        validateTokenViewModel.validateToken(textFieldCode: textFieldCode, button: buttonValidate, loading: loadingValidate, completion: { (response: Bool) in
            if response {
                self.goToLoginScreen()
            } else {
                self.validateTokenViewModel.showLoading(status: false, button: self.buttonValidate, loading: self.loadingValidate)
            }
        })
        
    }
    
    @IBAction func resendButton(_ sender: UIButton) {
        validateTokenViewModel.showLoading(status: true, button: buttonSendAgain, loading: loadingSendAgain )
        validateTokenViewModel.resendToken(completion: {(result) in
            self.viewWillAppear(true)
        })
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
