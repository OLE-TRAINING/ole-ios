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
    
    func getFilms(page: Int, id: Int, completion: @escaping ([Film], Int, Int) -> Void) {
        APIManager.shared.getFilmsByGenre(id: id, page: page) { (filmsByGenre) in
            self.movies.append(contentsOf: filmsByGenre.results)
            completion(self.movies, filmsByGenre.totalPages, filmsByGenre.page)
            
            if filmsByGenre.page == filmsByGenre.totalPages {
                //implementar comportamento
            }
            
        }
        
    }
    
    func loadForFilms(tableView: UITableView, loading: UIActivityIndicatorView) {
       
    }
    
    func getGenres(completion: @escaping ([Genre]) -> Void) {
        APIManager.shared.getFilmGenres { (genres) in
            var genre = [Genre]()
            for index in (genre) {
                if index.id == -1 {
                    genre.insert(index, at: 0)
                } else {
                    genre.append(index)
                }
                
                
            }
            completion(genre)
        }
        
    }
}
