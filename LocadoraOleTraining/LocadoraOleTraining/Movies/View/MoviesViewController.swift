//
//  MoviesViewController.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 12/11/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    var moviesViewModel = MoviesViewModel()

    var filmsByGener = [Film]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMovies()
    }
    
 
    
    static func instance() -> MoviesViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "MoviesViewController") as? MoviesViewController else {
            return nil
        }
        return viewController
    }
    
    func fetchMovies() {
        // TODO show loading
        //var filmGenres = [String]()
        
        moviesViewModel.getGenres(completion: { (genres, ids) in
            
//            for id in ids {
                self.moviesViewModel.getFilms(id: 2, completion: { [weak self] (films) in
                    self?.filmsByGener = films
                    //print("\(films)\n")
                    self?.tableView.reloadData()
                })
//            }
            
        })
        
    }

}

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func initTable() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // mudar tamanho da tabela quando chamar serviço
        //print(filmsByGener.count)
        return moviesViewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        //        cell.configureCell()
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? MovieTableViewCell else {
            return
        }
        let movie = moviesViewModel.movies[indexPath.row]
        // TODO
        cell.configureCell(films: filmsByGener)

    }
}
