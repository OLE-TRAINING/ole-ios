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
    
    func favorite(buttonLike: UIButton) {
        if buttonLike.currentImage == #imageLiteral(resourceName: "likeGreen") {
            buttonLike.setBackgroundImage(#imageLiteral(resourceName: "likeFullGreen"), for: UIControlState.normal)
        } else if buttonLike.currentImage == #imageLiteral(resourceName: "likeFullGreen") {
            buttonLike.setBackgroundImage(#imageLiteral(resourceName: "likeGreen"), for: UIControlState.normal)
        }
        
    }
    
    func setFilmInformations(films: [Film], labelFilmName: UILabel, labelFilmCategory: UILabel, labelFilmDuration: UILabel, labelFilmYear: UILabel, labelFilmSynopsis: UILabel, LabelFilmPrice: UILabel, labelNote: UILabel, imageFilm: UIImageView ) {
        for film in films {
            guard let posterId = film.posterId else { return }
            APIManager.shared.getImagePoster(id: posterId, size: "original") { (urlImage) in
                guard let url = URL(string: urlImage) else { return }
                imageFilm.setImageWith(url)
            }
            
            
            labelFilmName.text = film.title
            //labelFilmCategorie.text = film.genreNames
            labelFilmDuration.text = film.runtime
            labelFilmYear.text = String(film.year)
            labelFilmSynopsis.text = film.overview
            LabelFilmPrice.text = String(film.price)
            labelNote.text = String(film.voteAverage)
        }
        
        
    }
}
