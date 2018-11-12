//
//  MovieTableViewCell.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 12/11/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

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
    
    var movieCellViewModel = MovieCellViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(films: [Film]) {
        movieCellViewModel.configureCell(imageFilm: imageFilm, viewNote: viewNote, viewBack: viewBack, labelPrice: labelFilmPrice, viewYellPoint: viewYellPoint)
        movieCellViewModel.setFilmInformations(films: films, labelFilmName: labelFilmName, labelFilmCategory: labelFilmCategory, labelFilmDuration: labelFilmDuration, labelFilmYear: labelFilmYear, labelFilmSynopsis: labelFilmSynopsis, LabelFilmPrice: labelFilmPrice, labelNote: labelNote, imageFilm: imageFilm)
    }
    
    
    
    @IBAction func buttonLike(_ sender: UIButton) {
        movieCellViewModel.favorite(buttonLike: buttonLike)
    }
    


}
