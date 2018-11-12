//
//  CategoriesViewController.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 12/11/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit
import Pageboy
import Tabman

class CategoriesViewController: TabmanViewController {
    
    private var viewControllers = [UIViewController]()
    
    var filmGeners = [String]()
    var filmsByGener = [Film]()

    var categoriesViewModel = CategoriesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        self.navigationItem.titleView = categoriesViewModel.startHome()
//        configureBar()
        //initializeViewControllers(count: 20)
        
    }
    
    
    
    func configureBar()  {
        
        //parentPageboy?.scrollToPage(.next, animated: true)
        //self.isScrollEnabled = true
        
        let greenColor = UIColor(red: 0.070, green: 0.592, blue: 0.576   , alpha: 1)
        let yellowColor = UIColor(red: 1.0, green: 0.804, blue: 0.0, alpha: 1)
        
        
        
        initializeViewControllers(count: 20) //por enquanto, valor está fixo
        
        
        self.bar.style = .scrollingButtonBar
        self.bar.location = .top
        
        self.bar.appearance = TabmanBar.Appearance({ (appearance) in
            
            // customize appearance here
            appearance.state.color = UIColor.white
            appearance.state.selectedColor = UIColor.white
            appearance.text.font = .systemFont(ofSize: 14.0)
            //appearance.indicator.isProgressive = true
            appearance.indicator.color = yellowColor
            appearance.layout.interItemSpacing = 20.0
            appearance.style.background = .solid(color: greenColor)

        })
        
        dataSource = self
        
    }

}

extension CategoriesViewController: PageboyViewControllerDataSource  {
    
    private func initializeViewControllers(count: Int) {
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewControllers = [UIViewController]()
        var itens = [Item]()
        var filmGenres = [String]()
        
        categoriesViewModel.getGenres(completion: { (genres, ids) in
            
//            for id in ids {
//                self.categoriesViewModel.getFilms(id: id, completion: { (films) in
//                    self.filmsByGener = films
//                    print("\(films)\n")
//                })
//            }
            for genre in genres {
                //print("Filmes de \(genre): ")
                filmGenres.append(genre)
                //itens.append(Item(title: genre))
            }
            
            //            self.bar.items = itens
            //            viewControllers.append(viewController)
            for index in 0 ..< count {
//                let viewController = storyboard.instantiateViewController(withIdentifier: "ChildViewController") as! ChildViewController
//                viewController.index = index + 1
                let viewController = MoviesViewController.instance()
                itens.append(Item(title: filmGenres[index]))
                guard let vc = viewController else { return }
                viewControllers.append(vc)

            }

            self.bar.items = itens
            self.viewControllers = viewControllers
            self.reloadPages()
        })
        
        
    }
    

    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        //        initializeViewControllers(count: 20) // por enquanto, valor fixo
        return viewControllers.count
    }
    
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return self.viewControllers[index]
//        let viewController = MoviesViewController.instance()
//        return viewController
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}

