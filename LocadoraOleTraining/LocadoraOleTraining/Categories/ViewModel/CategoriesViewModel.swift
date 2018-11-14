//
//  CategoriesViewModel.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 12/11/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import Foundation

class CategoriesViewModel {
    
    init() {
        
    }
    
    
    func getGenres(completion: @escaping ([String], [Int]) -> Void) {
        
        APIManager.shared.getFilmGenres { (genres) in
            var genersForTab = [String]()
            var genredId = [Int]()
            for index in (genres?.genres)! {
                guard let gener = index.name else { return }
                let id = index.id
                genersForTab.append(gener)
                genredId.append(id)
                
            }
            completion(genersForTab, genredId)
        }
        
    }

    
    func getRangeOfSubString(subString: String, fromString: String) -> NSRange {
        let sampleLinkRange = fromString.range(of: subString)!
        let startPos = fromString.distance(from: fromString.startIndex, to: sampleLinkRange.lowerBound)
        let endPos = fromString.distance(from: fromString.startIndex, to: sampleLinkRange.upperBound)
        let linkRange = NSMakeRange(startPos, endPos - startPos)
        return linkRange
    }
}
