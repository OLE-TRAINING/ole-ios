//
//  MovieDetailsViewController.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 28/11/18.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

     
    @IBOutlet weak var tableView: UITableView!
    
    let movieDetailsViewModel = MovieDetailsViewModel()
    let similarityViewModel = SimilarityViewModel()
    let movieDetails = [Film]()
    var idFilm = 0
    var flag = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        self.navigationController?.hidesBarsOnSwipe = false       
        self.navigationItem.titleView = movieDetailsViewModel.startHome()
        self.navigationController?.isNavigationBarHidden = false
        let backButton = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(handleBackButton))
        backButton.title = " "
        backButton.tintColor = UIColor.white
        backButton.imageInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: -8)
        navigationItem.leftBarButtonItem = backButton
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        
    }

    @objc func handleBackButton(){
        self.navigationController?.popViewController(animated: true)
        
    }

}

extension MovieDetailsViewController: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        if section == 0 {
            rows = 1
        }
        else if section == 1 {
            rows = similarityViewModel.movies.count
        }

        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell0 = tableView.dequeueReusableCell(withIdentifier: "cellDetails") else {
                return UITableViewCell()
            }
            return cell0
        }
        
        if indexPath.section == 1 {
            guard let cell1 = tableView.dequeueReusableCell(withIdentifier: "cellSimilarity") else {
                return UITableViewCell()
            }
            return cell1
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            
            guard let cell = cell as? DetailsTableViewCell else {
                return
            }
//            let movie = moviesViewModel.movies[indexPath.row]
//            cell.configureCell(film: movie)
            if flag {
                cell.configureBorders()
                cell.setFilmDetails(id: self.idFilm)
                //tableView.reloadData()
            } else {
                tableView.reloadData()
            }
            
            
        }
        
        if indexPath.section == 1 {
            guard let cell = cell as? SimilarityTableViewCell else {
                return
            }

//            if showLoading {
//                cell.loadPage()
//            } else {
//                cell.hideLoading()
//            }


        }
    }

    
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//
//        let currentOffset = scrollView.contentOffset.y
//        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
//
//        if maximumOffset - currentOffset <= 10.0 && !isLoadingMore {
//            //print("CARREGANDO MAIS FILMES")
//            isLoadingMore = true
//            fetchMovies(page: page)
//            page += 1
//
//            tableView.reloadData()
//        }
//
//
//    }
    
    
}
