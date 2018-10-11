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
    
    // MARK:-  STATIC METHODS
    
    static func setaAtributosLabel(label: UILabel, labelText: String, size: CGFloat, fontFamily: String, spaceLine: Double, textColor: UIColor) {
        shared.setaAtributosLabel(label: label, labelText: labelText, size: size, fontFamily: fontFamily, spaceLine: spaceLine, textColor: textColor)
    }
    
    static func setaAtributosButton(button: UIButton) {
        shared.setaAtributosButton(button: button)
    }
    
    
    // MARK:-  IMPLEMENTATION OF STATIC METHODS
    
    func setaAtributosLabel(label: UILabel, labelText: String, size: CGFloat, fontFamily: String, spaceLine: Double, textColor: UIColor) {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        
        let font = UIFont(name: fontFamily, size: size) ?? UIFont.systemFont(ofSize: size)
        
        let attributes: [NSAttributedStringKey: Any] =
                [
                    .kern: spaceLine,
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
