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
    @IBOutlet weak var labelSubtitle: UILabel!
    @IBOutlet weak var textFieldNewPassword: UITextField!
    @IBOutlet weak var stackViewInvalidPassword: UIStackView!
    @IBOutlet weak var textFieldConfirmPassword: UITextField!
    @IBOutlet weak var stackViewInvalidConfirmation: UIStackView!
    @IBOutlet weak var buttonChangePassword: UIButton!
    @IBOutlet weak var loadingChangePassword: UIActivityIndicatorView!
    
    var emailUser: String?
    
    var viewModelNewPassword = ViewModelNewPassword()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelNewPassword.startTitles(labelTitle: labelTitle, email: emailUser, labelEmail: labelEmail, labelDidNotReceive: labelDidNotReceive, labelSubtitle: labelSubtitle)
        viewModelNewPassword.startStackViews(textFieldToken: textFieldToken, textFieldNewPassword: textFieldNewPassword, textFieldConfirmPassword: textFieldConfirmPassword, stackViewInvalidToken: stackViewInvalidToken, stackViewInvalidPassword: stackViewInvalidPassword, stackViewInvalidConfirmation: stackViewInvalidConfirmation)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModelNewPassword.showLoading(status: false, button: buttonChangePassword, loading: loadingChangePassword)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    @IBAction func buttonChangePassword(_ sender: UIButton) {
        viewModelNewPassword.showLoading(status: true, button: buttonChangePassword, loading: loadingChangePassword)
        viewModelNewPassword.changePassword(button: buttonChangePassword, loading: loadingChangePassword)
    }
    


}
