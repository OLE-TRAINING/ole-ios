//
//  MoviesViewModel.swift
//  LocadoraOleTraining
//
//  Created by Marcelo Mendes on 09/11/18.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

class MoviesViewModel: NSObject {

    var movies = [String]()

    func fetchMovies(completion: @escaping ([String]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: { [weak self] in
            self?.movies = ["1", "2", "3"]
            completion(self?.movies ?? [])
        })
    }

}
