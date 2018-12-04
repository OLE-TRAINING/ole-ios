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
    var filmsByGener = [Film]()
    var isLoadingMore = false
    var totalPages = 0
    var currentPage = 1
    var idFilm = 0
    var page = 2
    var showLoading = false
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
        fetchMovies(page: 1)
        
        
    }

    @objc func handleBackButton(){
        self.navigationController?.popViewController(animated: true)
        
    }

    func fetchMovies(page: Int) {

            self.movieDetailsViewModel.getSimilarFilms(page: page,id: idFilm , completion: { [weak self] (films, totalPages, currentPage) in
                self?.filmsByGener = films
                self?.showLoading = true
                self!.tableView.reloadData()
//                guard let viewLoading = self!.viewLoading else { return }
//                MBProgressHUD.hideAllHUDs(for: viewLoading, animated: true)
//                viewLoading.isHidden = true
                self!.isLoadingMore = false
                self?.totalPages = totalPages
                self?.currentPage = currentPage
                self!.tableView.reloadData()

                if totalPages == currentPage {
                    //implementar desaparecimento do loading
                }
            })

    }

}

extension MovieDetailsViewController: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        if section == 0 {
            rows = 1
        }
        else if section == 1 {
            rows = movieDetailsViewModel.movies.count
        } else if section == 2 {
            rows = 1
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
        
        if indexPath.section == 2 {
            guard let cell2 = tableView.dequeueReusableCell(withIdentifier: "cellLoading") else {
                return UITableViewCell()
            }
            return cell2
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
            guard let cell2 = cell as? SimilarityTableViewCell else {
                return
            }
            let movie = movieDetailsViewModel.movies[indexPath.row]
            cell2.configureCell(film: movie)
            
        }
        
        if indexPath.section == 2 {
            guard let cell3 = cell as? MovieTableViewCell else {
                return
            }
            
            if showLoading {
                cell3.loadPage()
            } else {
                cell3.hideLoading()
            }
            
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let textColor = UIColor(red: 0.357, green: 0.353, blue: 0.353, alpha: 1)
        let title = Attributes.shared.setAttributesText(labelText: "Opções semelhantes", size: 14, fontFamily: "Roboto-Light", spaceLine: 0.0, textColor: textColor)
        if section == 1 {
            return title.string
        }
        
        return ""
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maximumOffset - currentOffset <= 10.0 && !isLoadingMore {
            //print("CARREGANDO MAIS FILMES")
            isLoadingMore = true
            fetchMovies(page: page)
            page += 1
            
            tableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = tableView.indexPathForSelectedRow?.row
        self.idFilm = filmsByGener[selectedRow!].id
        self.flag = true
        tableView.reloadData()
        //tableView.setContentOffset(.zero, animated: true)
        tableView.layoutIfNeeded()
        tableView.contentOffset = CGPoint(x: 0, y: -tableView.contentInset.top)
    }

    
    
}
