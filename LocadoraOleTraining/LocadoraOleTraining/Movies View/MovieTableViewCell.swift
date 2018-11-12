//
//  MovieTableViewCell.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 05/11/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    var viewModel = MovieCellViewModel()
    
    @IBOutlet weak var imageFilm: UIImageView!
    @IBOutlet weak var iconFilm: UIImageView!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var viewNote: UIView!
    @IBOutlet weak var viewYellPoint: UIView!
    @IBOutlet weak var labelNote: UILabel!
    @IBOutlet weak var labelFilmName: UILabel!
    @IBOutlet weak var labelFilmCategory: UILabel!
    @IBOutlet weak var labelFilmDuration: UILabel!
    @IBOutlet weak var labelFilmYear: UILabel!
    @IBOutlet weak var labelFilmSynopsis: UILabel!
    @IBOutlet weak var labelFilmPrice: UILabel!
    @IBOutlet weak var buttonLike: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configureCell() {
        viewModel.configureCell(imageFilm: imageFilm, viewNote: viewNote, viewBack: viewBack, labelPrice: labelFilmPrice, viewYellPoint: viewYellPoint)
    }
    
    @IBAction func buttonLike(_ sender: UIButton) {
        viewModel.favorite(buttonLike: buttonLike)
    }
    
}


