//
//  HomeViewModel.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 01/11/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import Foundation

class HomeViewModel  {
    
  
    func startHome() -> UILabel {
        let navLabel = UILabel()
        let navTitle = NSMutableAttributedString(string: "OT", attributes:[
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.font: UIFont(name: "Dosis-Bold", size: 20)!])
        
        navTitle.append(NSMutableAttributedString(string: "Movies", attributes:[
            NSAttributedStringKey.font: UIFont(name: "Dosis-Regular", size: 20)!,
            NSAttributedStringKey.foregroundColor: UIColor.white]))
        
        navLabel.attributedText = navTitle
        
        return navLabel
    }
   
    
}
