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
    
    var viewController = UIViewController()
    var filmGenres = [Genre]()
    var filmsByGener = [Film]()

    @IBOutlet weak var viewLoading: UIView!
    
    var categoriesViewModel = CategoriesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    
    
    func configureBar()  {
        
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
        var viewControllers = [UIViewController]()
        var itens = [Item]()
        
        categoriesViewModel.getGenres(completion: { (genres) in

            self.filmGenres = genres
            let viewController = MoviesViewController.instance()
            guard let vc = viewController else { return }
            
            for index in 0 ..< count {
                
                let viewController = MoviesViewController.instance()
                guard let vc = viewController else { return }
                
                if index == 0 {
                    //Lamçamentos
                    itens.insert((Item(title: "Lançamentos")), at: index)
                    vc.genreId = self.filmGenres[index].id
                    viewControllers.insert(vc, at: 0)
                    
                } else {
                    guard let titleMovie = self.filmGenres[index].name else { return }
                    itens.append(Item(title: titleMovie))
                    vc.genreId = self.filmGenres[index].id
                    viewControllers.append(vc)
                    
                }

            }

            self.bar.items = itens
            self.viewController = vc
            self.viewControllers = viewControllers
            self.reloadPages()
            
        })
        
        
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
//        return 1
    }
    
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return self.viewControllers[index]

    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}

