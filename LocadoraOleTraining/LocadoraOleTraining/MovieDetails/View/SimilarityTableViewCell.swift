//
//  SimilarityTableViewCell.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 29/11/18.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

class SimilarityTableViewCell: UITableViewCell {

    var similarityViewModel = SimilarityViewModel()
    
    @IBOutlet weak var imageFilm: UIImageView!
    @IBOutlet weak var viewNote: UIView!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var viewYellPoint: UIView!
    @IBOutlet weak var labelFilmName: UILabel!
    @IBOutlet weak var labelFilmCategory: UILabel!
    @IBOutlet weak var labelFilmDuration: UILabel!
    @IBOutlet weak var labelFilmYear: UILabel!
    @IBOutlet weak var labelFilmSynopsis: UILabel!
    @IBOutlet weak var labelFilmPrice: UILabel!
    @IBOutlet weak var labelNote: UILabel!
    @IBOutlet weak var iconFilm: UIImageView!
    @IBOutlet weak var buttonLike: UIButton!
    @IBOutlet weak var loadingImage: UIActivityIndicatorView!
    @IBOutlet weak var loadingPages: UIActivityIndicatorView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(film: Film) {
        //ValidateForm.waitForImage(loading: loadingImage, imagePoster: imageFilm, flag: true)
        similarityViewModel.configureCell(imageFilm: imageFilm, viewNote: viewNote, viewBack: viewBack, labelPrice: labelFilmPrice, viewYellPoint: viewYellPoint)
        similarityViewModel.setFilmInformations(film: film, labelFilmName: labelFilmName, labelFilmCategory: labelFilmCategory, labelFilmDuration: labelFilmDuration, labelFilmYear: labelFilmYear, labelFilmSynopsis: labelFilmSynopsis, LabelFilmPrice: labelFilmPrice, labelNote: labelNote, imageFilm: imageFilm, iconFilm: iconFilm, buttonLike: buttonLike, loadingImage: loadingImage)
        
    }
    
    func loadPage() {
        loadingPages.isHidden = false
        loadingPages.startAnimating()
        
    }
    
    func hideLoading() {
        loadingPages.isHidden = true
    }

}
