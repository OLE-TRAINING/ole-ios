//
//  HomeViewModel.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 01/11/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import Foundation

class HomeViewModel  {
    
    //var filmGenres = Genres()
    
    init() {
        
    }
    
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
    
    func getGenres(completion: @escaping ([String]) -> Void, id: @escaping ([Int]) -> Void) {
        
        APIManager.shared.getFilmGenres { (genres) in
            var genersForTab = [String]()
            var genredId = [Int]()
            for index in (genres?.genres)! {
                guard let gener = index.name else { return }
                let id = index.id
                genersForTab.append(gener)
                genredId.append(id)
                
            }
            completion(genersForTab)
            id(genredId)
        }
        
    }
    
    func getFilms(id: Int, completion: @escaping ([Film]) -> Void) {
        APIManager.shared.getFilmsByGenre(id: id) { (films) in
            //print("Filmes de ação: \(films)")
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
