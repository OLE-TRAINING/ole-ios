//
//  TableViewMovies.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 19/11/18.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import Foundation

//class TableViewMovies: NSObject {
//    //var moviesViewModel = MoviesViewModel()
//    //var filmsByGener = [Film]()
//    var movies = [Film]()
//    
//    func getFilms(id: Int, completion: @escaping ([Film]) -> Void) {
//        APIManager.shared.getFilmsByGenre(id: id) { (films) in
//            self.movies = films
//            completion(films)
//            
//        }
//        
//    }
//    
//    func fetchMovies() {
//        getGenres(completion: { (genres, ids) in
//            
//            //for id in ids {
//                self.getFilms(id: 2, completion: { [weak self] (films) in
//                self?.movies = films
////                self.tableView.reloadData()
////                guard let viewLoading = self.viewLoading else { return }
////                MBProgressHUD.hideAllHUDs(for: viewLoading, animated: true)
////                viewLoading.isHidden = true
//            })
//            //}
//            
//            
//            
//        })
//        
//    }
//    
//    func getGenres(completion: @escaping ([String], [Int]) -> Void) {
//        
//        
//        APIManager.shared.getFilmGenres { (genres) in
//            var genersForTab = [String]()
//            var genredId = [Int]()
//            for index in (genres?.genres)! {
//                guard let gener = index.name else { return }
//                let id = index.id
//                genersForTab.append(gener)
//                genredId.append(id)
//                
//            }
//            completion(genersForTab, genredId)
//        }
//        
//    }
//}
//
//extension TableViewMovies: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // mudar tamanho da tabela quando chamar serviço
//        //print(filmsByGener.count)
//        return movies.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
//            return UITableViewCell()
//        }
//        return cell
//        
//    }
//    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        guard let cell = cell as? MovieTableViewCell else {
//            return
//        }
//        //let movie = movies[indexPath.row]
//        cell.configureCell(films: movies)
//        
//        
//    }
//}
