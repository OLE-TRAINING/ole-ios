//
//  ViewControllerNewPassword.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 29/10/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

class ViewControllerNewPassword: UIViewController {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var textFieldToken: UITextField!
    @IBOutlet weak var stackViewInvalidToken: UIStackView!
    @IBOutlet weak var labelDidNotReceive: UILabel!
    @IBOutlet weak var buttonSendAgain: UIButton!
    @IBOutlet weak var loadingSendAgain: UIActivityIndicatorView!
    @IBOutlet weak var labelSubtitle: UILabel!
    @IBOutlet weak var textFieldNewPassword: UITextField!
    @IBOutlet weak var stackViewInvalidPassword: UIStackView!
    @IBOutlet weak var textFieldConfirmPassword: UITextField!
    @IBOutlet weak var stackViewInvalidConfirmation: UIStackView!
    @IBOutlet weak var buttonChangePassword: UIButton!
    @IBOutlet weak var loadingChangePassword: UIActivityIndicatorView!
    
    var emailUser: String?
    
    var viewModelNewPassword = ViewModelNewPassword()
    
    var resultToken = false
    var resultPassword = false
    var resultConfirmPassword = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelNewPassword.startTitles(labelTitle: labelTitle, email: emailUser, labelEmail: labelEmail, labelDidNotReceive: labelDidNotReceive, labelSubtitle: labelSubtitle)
        viewModelNewPassword.startStackViews(textFieldToken: textFieldToken, textFieldNewPassword: textFieldNewPassword, textFieldConfirmPassword: textFieldConfirmPassword, stackViewInvalidToken: stackViewInvalidToken, stackViewInvalidPassword: stackViewInvalidPassword, stackViewInvalidConfirmation: stackViewInvalidConfirmation)
        buttonSendAgain.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        buttonSendAgain.contentVerticalAlignment = UIControlContentVerticalAlignment.top
        
        viewModelNewPassword.disableButton(button: buttonChangePassword)
        textFieldToken.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        textFieldNewPassword.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        textFieldConfirmPassword.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModelNewPassword.showLoading(status: false, button: buttonChangePassword, loading: loadingChangePassword)
        viewModelNewPassword.showLoading(status: false, button: buttonSendAgain, loading: loadingSendAgain)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == textFieldToken {
//            resultFullName = newRegistrationViewModel.checkFullName(textFieldFullName: textFieldFullName)
        }
        if textField == textFieldNewPassword {
//            resultUsername = newRegistrationViewModel.checkUsername(textFieldUsername: textFieldUsername, msgUsername: msgUsername)
        }
        
        if textField == textFieldConfirmPassword {
//            resultPassword = newRegistrationViewModel.checkPassword(textFieldPassword: textFieldPassword)
        }
        
        if resultToken && resultPassword && resultConfirmPassword {
        viewModelNewPassword.enableButton(button: buttonChangePassword)
        } else {
            viewModelNewPassword.disableButton(button: buttonChangePassword)
        }
    }
    
    @IBAction func buttonBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonSendAgain(_ sender: UIButton) {
        viewModelNewPassword.showLoading(status: true, button: buttonSendAgain, loading: loadingSendAgain)
        viewModelNewPassword.resendToken { (result) in
            self.viewWillAppear(true)
        }
    }
    
    @IBAction func buttonChangePassword(_ sender: UIButton) {
        viewModelNewPassword.showLoading(status: true, button: buttonChangePassword, loading: loadingChangePassword)
        viewModelNewPassword.changePassword(button: buttonChangePassword, loading: loadingChangePassword, completion: { (result) in
            if result {
                self.goToLoginScreen()
            } else {
                self.viewModelNewPassword.showLoading(status: false, button: self.buttonChangePassword, loading: self.loadingChangePassword)
            }
        })
    }
}

extension ViewControllerNewPassword {
    func goToLoginScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "login") as! LoginViewController
        if let email = labelEmail.text {
            controller.emailUser = email
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
