//
//  Atributos.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 10/10/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

class Atributos: NSObject {
    
    static let shared = Atributos()
    private override init() {}
    
    static func setaAtributosLabel(label: UILabel, labelText: String) {
        shared.setaAtributosLabel(label: label, labelText: labelText)
    }
    
    static func setaAtributosButton(button: UIButton) {
        shared.setaAtributosButton(button: button)
    }
    
    
    func setaAtributosLabel(label: UILabel, labelText: String) {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        
        let font = UIFont(name: "Dosis-Bold", size: 16) ?? UIFont.systemFont(ofSize: 16)
        let textColor = UIColor(red: 0.357, green: 0.353, blue: 0.353, alpha: 1)
        
        let attributes: [NSAttributedStringKey: Any] =
                [
                    .kern: 3.0,
                    .foregroundColor: textColor,
                    .font: font,
                    .paragraphStyle: paragraphStyle,
                    .baselineOffset: 2
                    
            ]
        let attributedQuote = NSAttributedString(string: labelText, attributes: attributes)
        label.attributedText = attributedQuote
        
    }
    
    func setaAtributosButton(button: UIButton) {
        button.layer.cornerRadius = 20;
    }
}
