//
//  HomeTableViewCell.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 05/11/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    
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
    
    var homeCellViewModel = HomeCellViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell() {
        homeCellViewModel.configureCell(imageFilm: imageFilm, viewNote: viewNote, viewBack: viewBack, labelPrice: labelFilmPrice, viewYellPoint: viewYellPoint)
    }
    
    @IBAction func buttonLike(_ sender: UIButton) {
        homeCellViewModel.favorite(buttonLike: buttonLike)
    }
    
}


