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
    var chechInformationViewModel = CheckInformationsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chechInformationViewModel.checkInformations(email: emailUser, labelTitle: labelTitle, labelEmail: labelEmail, stackViewUsername: stackViewUsername)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ValidateForm.showLoading(status: false, button: buttonGo, loading: loading)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func buttonBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func buttonGo(_ sender: UIButton) {
        ValidateForm.showLoading(status: true, button: buttonGo, loading: loading)
        chechInformationViewModel.validateUsername(textFieldUsername: textFieldUsername)
    }
    

}


