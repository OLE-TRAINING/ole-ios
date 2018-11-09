//
//  HomeViewController.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 30/10/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit
import Tabman
import Pageboy

class HomeViewController: TabmanViewController{
    
    @IBOutlet weak var tableFilms: UITableView!
    @IBOutlet weak var buttonMenu: UIButton!
    
    private var viewControllers = [UIViewController]()
    
    var filmGeners = [String]()
    var filmsByGener = [Film]()
    
    var homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTable()
        self.dataSource = self
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationItem.titleView = homeViewModel.startHome()
        configureBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func buttonBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func initTable() {
        self.tableFilms.dataSource = self
        self.tableFilms.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // mudar tamanho da tabela quando chamar serviço
        //print(filmsByGener.count)
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
//        let viagemAtual = listaViagens[indexPath.row]
//        cell.configuraCelula(viagem: viagemAtual)
        cell.configureCell()
        
        return cell
    }
    
    func configureBar()  {
        
        let greenColor = UIColor(red: 0.070, green: 0.592, blue: 0.576   , alpha: 1)
        let yellowColor = UIColor(red: 1.0, green: 0.804, blue: 0.0, alpha: 1)
        
//        homeViewModel.getGenres(completion: { (genres, ids) in
//            var itens = [Item]()
//            for id in ids {
//                self.homeViewModel.getFilms(id: id, completion: { (films) in
//                    self.filmsByGener = films
//                    //print("\(films)\n")
//                })
//            }
//            for genre in genres {
//                //print("Filmes de \(genre): ")
//                itens.append(Item(title: genre))
//            }
//
//            self.bar.items = itens
//
//        })
        
        initializeViewControllers(count: 20) //por enquanto, valor está fixo
        

        self.bar.style = .scrollingButtonBar
        self.bar.location = .top
        self.isScrollEnabled = true

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
    }
    
    func goToLoginScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "login") as! LoginViewController
//        if let email = labelEmail.text {
//            controller.emailUser = email
//        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension HomeViewController: PageboyViewControllerDataSource  {

    private func initializeViewControllers(count: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewControllers = [UIViewController]()
        var itens = [Item]()
        var filmGenres = [String]()
        
        homeViewModel.getGenres(completion: { (genres, ids) in
            
            for id in ids {
                self.homeViewModel.getFilms(id: id, completion: { (films) in
                    self.filmsByGener = films
                    //print("\(films)\n")
                })
            }
            for genre in genres {
                //print("Filmes de \(genre): ")
                filmGenres.append(genre)
                //itens.append(Item(title: genre))
            }
//            self.bar.items = itens
//            viewControllers.append(viewController)
            for index in 0 ..< count {
                let viewController = storyboard.instantiateViewController(withIdentifier: "ChildViewController") as! ChildViewController
                viewController.index = index + 1
                itens.append(Item(title: filmGenres[index]))
                viewControllers.append(viewController)
                
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
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}

