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
    var page = 2
    var isLoadingMore = false
    var totalPages = 0
    var currentPage = 1
    var showLoading = false
    var currentFilm = Film()
    
    @IBOutlet weak var viewLoading: UIView!
    @IBOutlet weak var tableView: UITableView!
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.hidesBarsOnSwipe = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let loadingNotification = MBProgressHUD.showAdded(to: self.viewLoading, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        fetchMovies(page: 1)
//        testSessionExpired()
        
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        filmsByGener = [Film]()
//    }
    
    
    static func instance() -> MoviesViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "MoviesViewController") as? MoviesViewController else {
            return nil
        }
        return viewController
    }
    
    func fetchMovies(page: Int) {
        
        moviesViewModel.getGenres(completion: { (genres) in
            
            self.moviesViewModel.getFilms(page: page,id: self.genreId , completion: { [weak self] (films, totalPages, currentPage) in
                self?.filmsByGener = films
                self?.showLoading = true
                self?.tableView.reloadData()
                guard let viewLoading = self!.viewLoading else { return }
                MBProgressHUD.hideAllHUDs(for: viewLoading, animated: true)
                viewLoading.isHidden = true
                self?.isLoadingMore = false
                self?.totalPages = totalPages
                self?.currentPage = currentPage
                if totalPages == currentPage {
                    //implementar desaparecimento do loading 
                }
            })
            
        })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowDetailsSegue" 
        {
            if let destinationVC = segue.destination as? MovieDetailsViewController {
                let selectedRow = tableView.indexPathForSelectedRow?.row
                destinationVC.idFilm = filmsByGener[selectedRow!].id
                destinationVC.flag = true

            }
        }
        
    }

}

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {

//    func refreshTable(){
//        let indexPathForSection = IndexSet([0])
//        tableView.reloadSections(indexPathForSection, with: .automatic)
//    }
//
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
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
        if indexPath.section == 0 {
            guard let cell0 = tableView.dequeueReusableCell(withIdentifier: "cell") else {
                return UITableViewCell()
            }
            return cell0
        }
        
        if indexPath.section == 1 {
            guard let cell1 = tableView.dequeueReusableCell(withIdentifier: "cellLoading") else {
                return UITableViewCell()
            }
            return cell1
        }
        
        return UITableViewCell()
        
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            
            guard let cell = cell as? MovieTableViewCell else {
                return
            }
            let movie = moviesViewModel.movies[indexPath.row]
            cell.configureCell(film: movie)
        }
        
        if indexPath.section == 1 {
            guard let cell = cell as? MovieTableViewCell else {
                return
            }
            
            if showLoading {
                cell.loadPage()
            } else {
                cell.hideLoading()
            }
            
        }
    }
    
    
    

   
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maximumOffset - currentOffset <= 10.0 && !isLoadingMore {
            //print("CARREGANDO MAIS FILMES")
            isLoadingMore = true
            fetchMovies(page: page)
            page += 1
            
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


