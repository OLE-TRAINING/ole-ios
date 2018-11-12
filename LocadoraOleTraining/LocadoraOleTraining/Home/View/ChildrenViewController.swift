//
//  ChildrenViewController.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 09/11/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import Foundation

import UIKit

class ChildViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var promptLabel: UILabel!
    
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let index = self.index {
            self.label.text = "Page " + String(index)
            self.promptLabel.isHidden = index != 1
            
        }
    }
    
    func doSomething() {
        parentPageboy?.scrollToPage(.next, animated: true)
    }
    
}
