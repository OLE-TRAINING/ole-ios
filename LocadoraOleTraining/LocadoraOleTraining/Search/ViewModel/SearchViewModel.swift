//
//  SearchViewModel.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 27/11/18.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import Foundation

class SearchViewModel {
    var movies = [Film]()
    
    func getFilms(page: Int, filmName: String, completion: @escaping ([Film], Int, Int) -> Void) {
        APIManager.shared.getFilmsByName(filmName: filmName, page: page) { (filmsByGenre) in
            if page > 1 {
                self.movies.append(contentsOf: filmsByGenre.results)
            } else {
                self.movies = filmsByGenre.results
            }
            completion(self.movies, filmsByGenre.totalPages, filmsByGenre.page)
            
            if filmsByGenre.page == filmsByGenre.totalPages {
                //implementar comportamento
            }
            
        }
        
    }
    

}
