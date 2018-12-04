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
    
    
    func getGenres(completion: @escaping ([Genre]) -> Void) {
        APIManager.shared.getFilmGenres { (genres) in
            var genre = [Genre]()
            for index in (genres?.genres)! {
                if index.id == -1 {
                    genre.insert(index, at: 0)
                } else {
                    genre.append(index)
                }
                
            }
            completion(genre)
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
