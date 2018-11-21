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
    var genreId = 0
    //var tableViewMovies = TableViewMovies()
   
    @IBOutlet weak var viewLoading: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.initTable()
        self.navigationController?.hidesBarsOnSwipe = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
      
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
        moviesViewModel.getGenres(completion: { (genres) in

            //for genre in genres {
                self.moviesViewModel.getFilms(id: self.genreId , completion: { [weak self] (films) in
                    self?.filmsByGener = films
                    self!.tableView.reloadData()
                    guard let viewLoading = self!.viewLoading else { return }
                    MBProgressHUD.hideAllHUDs(for: viewLoading, animated: true)
                    viewLoading.isHidden = true
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

    internal func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        if section == 0 {
            rows = moviesViewModel.movies.count
        } else if section == 1 {
            rows =  1
        }
        
        return rows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       var cell = UITableViewCell()
        if indexPath.row == 0 {
            guard let cell0 = tableView.dequeueReusableCell(withIdentifier: "cell") else {
                return UITableViewCell()
            }
            cell = cell0
        } else if indexPath.row == 1 {
            guard let cell1 = tableView.dequeueReusableCell(withIdentifier: "cellLoading") else {
                return UITableViewCell()
            }
            cell = cell1
        }
        
        return cell
        
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            guard let cell = cell as? MovieTableViewCell else {
                return
            }
            let movie = moviesViewModel.movies[indexPath.row]
            cell.configureCell(film: movie)
        } else if indexPath.row == 1{
            guard let cell = cell as? MovieTableViewCell else {
                return
            }
            cell.loadPage()
        }


    }
    
    
    
}

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


