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
    
    var homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTable()
        self.dataSource = self
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
        return 3
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
        // receber os titulos de cada página do backend
        self.bar.items = [Item(title: "Lançamentos"),
                          Item(title: "Ação"),
                          Item(title: "Aventura"),
                          Item(title: "Animação"),
                          Item(title: "Comédia"),
                          Item(title: "Drama")]

        self.bar.style = .scrollingButtonBar
        self.bar.location = .top
        

        self.bar.appearance = TabmanBar.Appearance({ (appearance) in

            // customize appearance here
            appearance.state.color = UIColor.white
            appearance.state.selectedColor = UIColor.white
            appearance.text.font = .systemFont(ofSize: 14.0)
            appearance.indicator.isProgressive = true
            appearance.indicator.color = yellowColor
            appearance.layout.interItemSpacing = 20.0
            appearance.style.background = .solid(color: greenColor)


        })
    }
    
}

extension HomeViewController: PageboyViewControllerDataSource  {

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    

    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}

