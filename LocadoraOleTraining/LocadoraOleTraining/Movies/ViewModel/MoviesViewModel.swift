//
//  MoviesViewModel.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 12/11/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import Foundation

class MoviesViewModel {
     var movies = [Film]()
    
    func getFilms(id: Int, completion: @escaping ([Film]) -> Void) {
        APIManager.shared.getFilmsByGenre(id: id) { (films) in
            //print("Filmes de ação: \(films)")
            self.movies = films
            completion(films)
            
        }
        
    }
    
    func loadForFilms(tableView: UITableView, loading: UIActivityIndicatorView) {
       
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
            //id(genredId)
        }
        
    }
}
