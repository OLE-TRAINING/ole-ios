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
        let normalString = "OTMovie"
        
        let attributedText = NSMutableAttributedString(string: normalString)
        
        attributedText.addAttributes([NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name: "Dosis-Bold", size: 20)!], range:    getRangeOfSubString(subString: "OT", fromString: normalString))
        
        attributedText.addAttributes([NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name: "Dosis-Regular", size: 20)!], range:  getRangeOfSubString(subString: "Movie", fromString: normalString))
        
        labelTitle.attributedText = attributedText
    }
    
    func getRangeOfSubString(subString: String, fromString: String) -> NSRange {
        let sampleLinkRange = fromString.range(of: subString)!
        let startPos = fromString.distance(from: fromString.startIndex, to: sampleLinkRange.lowerBound)
        let endPos = fromString.distance(from: fromString.startIndex, to: sampleLinkRange.upperBound)
        let linkRange = NSMakeRange(startPos, endPos - startPos)
        return linkRange
    }
    
    func configuraBar() {
        
    }
    
    
}
