//
//  SearchViewController.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 27/11/18.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit
import MBProgressHUD

class SearchViewController: UIViewController, UISearchBarDelegate    {

    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var viewLoading: UIView!
    
    var searchViewModel = SearchViewModel()
    var filmsByGener = [Film]()
    var isLoadingMore = false
    var page = 2
    var totalPages = 0
    var currentPage = 1
    var showLoading = false
    var searchText = ""
    var noResults = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchBar.delegate = self
        viewLoading.isHidden = true
        
    }
    
    @IBAction func tapToHideKeyboard(_ sender: UITapGestureRecognizer) {
        self.searchBar.resignFirstResponder()
    }
    
    func fetchMovies(page: Int, searchText: String) {
        viewLoading.isHidden = false
        let loadingNotification = MBProgressHUD.showAdded(to: self.viewLoading, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        self.searchViewModel.getFilms(page: page, filmName: searchText, completion: { [weak self] (films, totalPages, currentPage) in
            self?.filmsByGener = films
            if totalPages == 0 {
                self?.noResults = true
                guard let viewLoading = self!.viewLoading else { return }
                MBProgressHUD.hideAllHUDs(for: viewLoading, animated: true)
                viewLoading.isHidden = true
                self!.searchTableView.reloadData()
                
            } else {
                self?.showLoading = true
                self!.searchTableView.reloadData()
                guard let viewLoading = self!.viewLoading else { return }
                MBProgressHUD.hideAllHUDs(for: viewLoading, animated: true)
                viewLoading.isHidden = true
                self!.isLoadingMore = false
                self?.totalPages = totalPages
                self?.currentPage = currentPage
                
                
                if totalPages == currentPage {
                    //print("Sem mais páginas para carregar")
                }
            }
            
        })
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        trySearch()
        self.searchText = searchText
    }
    
    
    func trySearch() {
        SearchViewController.cancelPreviousPerformRequests(withTarget: self)
        self.perform(#selector(search), with: nil, afterDelay: 0.5)
    }
    
    @objc func search() {
        fetchMovies(page: 1, searchText: self.searchText)
        searchTableView.reloadData()
    }

}


extension SearchViewController: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        if section == 0 {
            rows = searchViewModel.movies.count
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
            
            guard let cell = cell as? SearchTableViewCell else {
                return
            }
            let movie = searchViewModel.movies[indexPath.row]
            cell.configureCell(film: movie)
        }
        
        if indexPath.section == 1 {
            guard let cell = cell as? SearchTableViewCell else {
                return
            }
            if showLoading {
                cell.loadPage()
            } else {
                cell.hideLoading()
            }
            
            cell.configureNoResultsLabel(searchText: searchText)
            cell.noResultsForSearch(noResults)
            
            
        }
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maximumOffset - currentOffset <= 10.0 && !isLoadingMore {
            isLoadingMore = true
            guard let searchText = searchBar.text else { return }
            fetchMovies(page: page, searchText: searchText)
            page += 1
            searchTableView.reloadData()
        }
        
        
    }
    
    
}



