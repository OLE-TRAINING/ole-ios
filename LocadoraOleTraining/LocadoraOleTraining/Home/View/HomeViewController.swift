//
//  HomeViewController.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 30/10/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {

    @IBOutlet weak var tableFilms: UITableView!
    @IBOutlet weak var buttonMenu: UIButton!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var pagerView: UIView!
    
    var homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.startHome(labelTitle: labelTitle)
        self.initTable()
        
        
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
    
    
}


