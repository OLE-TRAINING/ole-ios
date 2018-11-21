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
            self.movies = films
            completion(films)
            
        }
        
    }
    
    func loadForFilms(tableView: UITableView, loading: UIActivityIndicatorView) {
       
    }
    
    func getGenres(completion: @escaping ([Genre]) -> Void) {
        
        
        APIManager.shared.getFilmGenres { (genres) in
            var genre = [Genre]()
            for index in (genre) {
                genre.append(index)
                
            }
            completion(genre)
        }
        
    }
}
