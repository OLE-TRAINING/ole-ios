//
//  CheckInformationsViewController.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 25/10/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

class CheckInformationsViewController: UIViewController {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var buttonGo: UIButton!
    @IBOutlet weak var stackViewUsername: UIStackView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var emailUser: String?
    var checkInformationViewModel = CheckInformationsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkInformationViewModel.checkInformations(email: emailUser, labelTitle: labelTitle, labelEmail: labelEmail, stackViewUsername: stackViewUsername)
        checkInformationViewModel.disableButton(button: buttonGo)
        textFieldUsername.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkInformationViewModel.showLoading(status: false, button: buttonGo, loading: loading)
    }

    @IBAction func buttonBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        if checkInformationViewModel.checkUsername(textFieldUsername: textFieldUsername) {
            checkInformationViewModel.enableButton(button: buttonGo)
        } else {
            checkInformationViewModel.disableButton(button: buttonGo)
        }
    }

    
    @IBAction func buttonGo(_ sender: UIButton) {
        checkInformationViewModel.showLoading(status: true, button: buttonGo, loading: loading)
        checkInformationViewModel.validateUsername(textFieldUsername: textFieldUsername, button: buttonGo, loading: loading, completion:{ (result) in
            if result {
                self.goToNewPasswordScreen()
            } else {
                self.checkInformationViewModel.showLoading(status: false, button: self.buttonGo, loading: self.loading)
            }
        })
    }
    
}

extension CheckInformationsViewController {
    func goToNewPasswordScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "trocaSenha") as! ViewControllerNewPassword
        if let email = labelEmail.text {
            controller.emailUser = email
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
}


