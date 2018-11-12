//
//  MoviesViewController.swift
//  LocadoraOleTraining
//
//  Created by Marcelo Mendes on 09/11/18.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    var viewModel = MoviesViewModel()

    @IBOutlet weak var tableView: UITableView!
    
    static func instance() -> MoviesViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "MoviesViewController") as? MoviesViewController else {
            return nil
        }
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMovies()
    }

    func configTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }

    func fetchMovies() {
        // TODO show loading
        viewModel.fetchMovies(completion: { [weak self] (movies) in
            // TODO hide loading
            self?.tableView.reloadData()
        })
    }

}

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? MovieTableViewCell else {
            return
        }
        let movie = viewModel.movies[indexPath.row]
        // TODO
    }
}
