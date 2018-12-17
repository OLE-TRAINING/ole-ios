//
//  RoundedButton.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 19/10/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        initProperties()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initProperties()
    }
    
    private func initProperties() {
        
        layer.cornerRadius = 20;
    }

}
