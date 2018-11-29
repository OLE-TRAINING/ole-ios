//
//  DetailsCellViewModel.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 28/11/18.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import Foundation


class DetailsCellViewModel {
    
    func configureBorders(imagePoster: UIImageView, viewPlay: UIView, viewIMDB: UIView) {
        viewPlay.layer.cornerRadius = 18
        viewIMDB.layer.cornerRadius = 5
        
        imagePoster.layer.cornerRadius = 5
        imagePoster.layer.masksToBounds = true
    }
    
    func setFilmDetails(id: Int, labelFilmName: UILabel, labelGenres: UILabel, labelNote: UILabel, labelTime: UILabel, labelDirector: UILabel, labelWriter: UILabel, labelSynopsis: UILabel, imagePoster: UIImageView, imageBanner: UIImageView, buttonLike: UIButton) {
        APIManager.shared.getFilmDetails(id: id) { (details) in
            labelFilmName.text = details.title
            labelGenres.text = ValidateForm.shared.arrayToString(array: details.genreNames)
            labelNote.text = "\(String(details.voteAverage))/10"
            guard let duration = details.runtime else { return }
            labelTime.text = "\(details.year) \(ValidateForm.shared.arrayToString(array: details.countries)) \(duration)"
            labelDirector.text = "Escritores: \(ValidateForm.shared.arrayToString(array: details.directors))"
            labelWriter.text = "Diretores: \(ValidateForm.shared.arrayToString(array: details.writers))"
            labelSynopsis.text = details.overview
            guard let posterId = details.posterId else { return }
            guard let urlPoster = APIManager.shared.getImagePoster(id: posterId, size: "original") else { return }
            DispatchQueue.main.async {
                imagePoster.setImageWith(urlPoster)
            }
            guard let bannerId = details.bannerId else { return }
            guard let urlBanner = APIManager.shared.getImagePoster(id: bannerId, size: "original") else { return }
            DispatchQueue.main.async {
                imageBanner.setImageWith(urlBanner)
            }
            ValidateForm.checkFavorite(buttonLike: buttonLike, favorite: details.favorit)
        }
    }
//
//    func setFilmInformations(film: FilmDetails, labelFilmName: UILabel, labelFilmGenres: UILabel, labelNote: UILabel, labelTime: UILabel ,labelFilmDuration: UILabel, labelFilmYear: UILabel,  imagePoster: UIImageView, imageBanner: UIImageView, buttonLike: UIButton, labelFilmSynopsis: UILabel) {
////        ValidateForm.waitForImage(loading: loadingImage, imagePoster: imageFilm, flag: true)
//
//        var genresName = ""
//        guard let posterId = film.posterId else { return }
//        guard let url = APIManager.shared.getImagePoster(id: posterId, size: "original") else { return }
//        DispatchQueue.main.async {
//            imagePoster.setImageWith(url)
//
//        }
//        //ValidateForm.waitForImage(loading: loadingImage, imagePoster: imageFilm, flag: false)
//
//        labelFilmName.text = film.title
//        for genre in film.genreNames {
//            if genresName == "" {
//                genresName = genre
//            } else {
//                genresName = genresName + ", " + genre
//            }
//
//        }
//        labelFilmGenres.text = genresName
//        for genre in film. {
//            if genresName == "" {
//                genresName = genre
//            } else {
//                genresName = genresName + ", " + genre
//            }
//
//        }
//        labelTime.text = "\(film.year) \()"
//        labelFilmDuration.text = film.runtime
//        labelFilmYear.text = String(film.year)
//        labelFilmSynopsis.text = film.overview
//        labelNote.text = "\(String(film.voteAverage))/10"
//
////        ValidateForm.checkFilmAcquired(acquired: film.acquired, labelPrice: LabelFilmPrice, imageAcquired: iconFilm)
//        ValidateForm.checkFavorite(buttonLike: buttonLike, favorite: film.favorit)
//
//    }
}
