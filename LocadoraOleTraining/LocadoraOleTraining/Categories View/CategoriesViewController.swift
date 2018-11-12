//
//  CategoriesViewController.swift
//  LocadoraOleTraining
//
//  Created by Marcelo Mendes on 09/11/18.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

import Pageboy
import Tabman

class CategoriesViewController: TabmanViewController {

    var viewModel = CategoriesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCategories()
    }

    func configureBar()  {

        let greenColor = UIColor(red: 0.070, green: 0.592, blue: 0.576   , alpha: 1)
        let yellowColor = UIColor(red: 1.0, green: 0.804, blue: 0.0, alpha: 1)

        self.bar.style = .scrollingButtonBar
        self.bar.location = .top

        self.bar.appearance = TabmanBar.Appearance({ (appearance) in
            appearance.state.color = UIColor.white
            appearance.state.selectedColor = UIColor.white
            appearance.text.font = .systemFont(ofSize: 14.0)
            appearance.indicator.isProgressive = false
            appearance.indicator.color = yellowColor
            appearance.layout.interItemSpacing = 20.0
            appearance.style.background = .solid(color: greenColor)
        })

        dataSource = self
    }

    func fetchCategories() {
        viewModel.fetchCategories(completion: { [weak self] (categories) in
            let items = categories.map() { return Item(title: $0) }
            self?.bar.items = items
            self?.reloadPages()
        })
    }
}

extension CategoriesViewController: PageboyViewControllerDataSource {
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewModel.pages.count
    }

    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
//        let category = viewModel.pages[index]
        let viewController = MoviesViewController.instance()
        return viewController
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}
