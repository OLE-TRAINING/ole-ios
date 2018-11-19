//
//  MoviesViewController.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 12/11/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit
import MBProgressHUD


class MoviesViewController: UIViewController {

    var moviesViewModel = MoviesViewModel()
    var filmsByGener = [Film]()
    var tableViewMovies = TableViewMovies()
   
    @IBOutlet weak var viewLoading: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.initTable()
        self.navigationController?.hidesBarsOnSwipe = true
        self.tableView.delegate = self.tableViewMovies
        self.tableView.dataSource = self.tableViewMovies
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let loadingNotification = MBProgressHUD.showAdded(to: self.viewLoading, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        fetchMovies()
//        testSessionExpired()
        
    }
    
    
    
    static func instance() -> MoviesViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "MoviesViewController") as? MoviesViewController else {
            return nil
        }
        return viewController
    }
    
    func fetchMovies() {
//        moviesViewModel.getGenres(completion: { (genres, ids) in
//
//            //for id in ids {
//                self.moviesViewModel.getFilms(id: 2, completion: { [weak self] (films) in
//                    self?.filmsByGener = films
                    tableView.reloadData()
                    guard let viewLoading = viewLoading else { return }
                    MBProgressHUD.hideAllHUDs(for: viewLoading, animated: true)
                    viewLoading.isHidden = true
//                })
//            //}
//
//
//
//        })

    }

}

//extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
//
//    func initTable() {
//        self.tableView.dataSource = self
//        self.tableView.delegate = self
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // mudar tamanho da tabela quando chamar serviço
//        //print(filmsByGener.count)
//        return moviesViewModel.movies.count
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
//        let movie = moviesViewModel.movies[indexPath.row]
//        cell.configureCell(films: filmsByGener)
//
//
//    }
//}

extension MoviesViewController {
    func testSessionExpired() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            delegate.notifySessionExpired()
        })
    }

}


