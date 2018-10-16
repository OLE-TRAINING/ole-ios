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
    
    static func setaAtributosBordaTextField(textField: UITextField, cor: UIColor, width: CGFloat) {
        shared.setaAtributosBordaTextField(textField: textField, cor: cor, width: width)
    }
    
    static func setaAtributosIniciais(textField: UITextField, stackView: UIStackView) {
        shared.setaAtributosIniciais(textField: textField, stackView: stackView)
    }
    
    static func setaAtributosCampoInvalido(textField: UITextField, stackView: UIStackView) {
        shared.setaAtributosCampoInvalido(textField: textField, stackView: stackView)
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
    
    func setaAtributosBordaTextField(textField: UITextField, cor: UIColor, width: CGFloat) {
        
        textField.layer.borderColor = cor.cgColor
        textField.layer.borderWidth = width
    }
    
    func setaAtributosIniciais(textField: UITextField, stackView: UIStackView) {
        let textColor = UIColor(red: 0.357, green: 0.353, blue: 0.353, alpha: 1)
        Atributos.setaAtributosBordaTextField(textField: textField, cor: textColor, width: 0.0)
        stackView.isHidden = true
    }
    
    func setaAtributosCampoInvalido(textField: UITextField, stackView: UIStackView) {
        let borderColor = UIColor(red: 0.99, green: 0.098, blue: 0.141, alpha: 1)
        Atributos.setaAtributosBordaTextField(textField: textField, cor: borderColor, width: 1.0)
        stackView.isHidden = false
    }
    
    
}
