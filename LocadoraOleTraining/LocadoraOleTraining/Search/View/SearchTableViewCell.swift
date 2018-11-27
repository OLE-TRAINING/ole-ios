//
//  SearchTableViewCell.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 27/11/18.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    
    @IBOutlet weak var filmImage: UIImageView!
    @IBOutlet weak var labelFilmName: UILabel!
    @IBOutlet weak var labelFilmCategory: UILabel!
    @IBOutlet weak var labelFilmDuration: UILabel!
    @IBOutlet weak var imageAquired: UIImageView!
    @IBOutlet weak var labelFilmPrice: UILabel!
    @IBOutlet weak var labelFilmYear: UILabel!
    @IBOutlet weak var buttonLike: UIButton!
    @IBOutlet weak var viewNote: UIView!
    @IBOutlet weak var viewPoint: UIView!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var loadingFilmImage: UIActivityIndicatorView!
    @IBOutlet weak var labelNote: UILabel!
    @IBOutlet weak var labelFilmSynopsis: UILabel!
    @IBOutlet weak var loadingPages: UIActivityIndicatorView!
    @IBOutlet weak var labelNoResults: UILabel!
    
    var page = 2
    var searchCellViewModel = SearchCellViewModel()
    
    
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
        searchCellViewModel.configureCell(imageFilm: filmImage, viewNote: viewNote, viewBack: viewBack, labelPrice: labelFilmPrice, viewYellPoint: viewPoint)
        searchCellViewModel.setFilmInformations(film: film, labelFilmName: labelFilmName, labelFilmCategory: labelFilmCategory, labelFilmDuration: labelFilmDuration, labelFilmYear: labelFilmYear, labelFilmSynopsis: labelFilmSynopsis, LabelFilmPrice: labelFilmPrice, labelNote: labelNote, imageFilm: filmImage, iconFilm: imageAquired, buttonLike: buttonLike, loadingImage: loadingFilmImage)
    }
    
    func noResultsForSearch(_ flag: Bool) {
        if flag {
            labelNoResults.isHidden = false
            loadingPages.isHidden = true
        } else {
            labelNoResults.isHidden = true
        }
        
    }
    
    func loadPage() {
        loadingPages.isHidden = false
        loadingPages.startAnimating()

    }
    
    func hideLoading() {
        loadingPages.isHidden = true
        labelNoResults.isHidden = true
    }

}


