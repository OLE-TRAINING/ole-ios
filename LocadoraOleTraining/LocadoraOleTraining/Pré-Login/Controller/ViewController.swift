//
//  ViewController.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 10/10/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Atributos.setaAtributosLabel(label: LabelEmail, labelText: "INFORME SUA CONTA DE E-MAIL")
        Atributos.setaAtributosButton(button: ButtonAvancar)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBOutlet weak var LabelEmail: UILabel!
    
    @IBOutlet weak var ButtonAvancar: UIButton!
    
    
}





