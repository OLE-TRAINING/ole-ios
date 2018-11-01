//
//  HomeViewModel.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 01/11/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    init() {
        
    }
    
    func startHome(labelTitle: UILabel) {
        let textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
        Attributes.setAttributesLabel(label: labelTitle, labelText: "OTMovies", size: 18, fontFamily: "Dosis-Bold", spaceLine: 0, textColor: textColor)

    }
    
    
}
