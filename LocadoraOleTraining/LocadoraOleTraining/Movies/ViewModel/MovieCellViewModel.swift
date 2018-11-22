//
//  MovieCellViewModel.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 12/11/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import Foundation

class MovieCellViewModel {
    init() {
        
    }
    
    var movies = [Film]()
    
    
    func configureCell(imageFilm : UIImageView, viewNote: UIView, viewBack: UIView, labelPrice: UILabel, viewYellPoint: UIView) {
        viewNote.layer.cornerRadius = 18
        viewYellPoint.layer.cornerRadius = 5
        viewBack.layer.cornerRadius = 5
        
        imageFilm.layer.cornerRadius = 5
        imageFilm.layer.masksToBounds = true
        
        labelPrice.layer.shadowRadius = 3.0
        labelPrice.layer.shadowOpacity = 0.6
        labelPrice.layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    
    
    
    func setFilmInformations(film: Film, labelFilmName: UILabel, labelFilmCategory: UILabel, labelFilmDuration: UILabel, labelFilmYear: UILabel, labelFilmSynopsis: UILabel, LabelFilmPrice: UILabel, labelNote: UILabel, imageFilm: UIImageView, iconFilm: UIImageView, buttonLike: UIButton, loadingImage: UIActivityIndicatorView) {
        
        var genresName = ""
        guard let posterId = film.posterId else { return }
        guard let url = APIManager.shared.getImagePoster(id: posterId, size: "original") else { return }
        imageFilm.setImageWith(url)
        labelFilmName.text = film.title
        for genre in film.genreNames {
            if genresName == "" {
                genresName = genre
            } else {
                genresName = genresName + ", " + genre
            }
            
        }
        labelFilmCategory.text = genresName
        labelFilmDuration.text = film.runtime
        labelFilmYear.text = String(film.year)
        labelFilmSynopsis.text = film.overview
        LabelFilmPrice.text = "R$ " + String(film.price)
        labelNote.text = String(film.voteAverage)
        
        ValidateForm.checkFilmAcquired(acquired: film.acquired, labelPrice: LabelFilmPrice, imageAcquired: iconFilm)
        ValidateForm.checkFavorite(buttonLike: buttonLike, favorite: film.favorit)
        
    }
    

        

    
}
