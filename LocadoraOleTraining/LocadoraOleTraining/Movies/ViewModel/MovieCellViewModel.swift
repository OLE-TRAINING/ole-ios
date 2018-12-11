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
        loadingImage.startAnimating()
        imageFilm.isHidden = true
        
        guard let posterId = film.posterId else { return }
        guard let url = APIManager.shared.getImagePoster(id: posterId, size: "original") else { return }
//        imageFilm.setImageWith(url)
        let request = URLRequest(url: url)
        imageFilm.setImageWith(request, placeholderImage: UIImage(named: "noPosterImg"), success: { (request, response, image) in
            imageFilm.isHidden = false
            imageFilm.image = image.resizeImage(CGSize(width: 125, height: 180))
            loadingImage.isHidden = true
        }) { (request, response, error) in
            imageFilm.isHidden = false
            loadingImage.isHidden = true
        }

        labelFilmName.text = film.title
        labelFilmCategory.text = ValidateForm.arrayToString(array: film.genreNames)
        labelFilmDuration.text = film.runtime
        labelFilmYear.text = String(film.year)
        labelFilmSynopsis.text = film.overview
        LabelFilmPrice.text = "R$ " + String(film.price)
        labelNote.text = String(film.voteAverage)
        
        ValidateForm.checkFilmAcquired(acquired: film.acquired, labelPrice: LabelFilmPrice, imageAcquired: iconFilm)
        ValidateForm.checkFavorite(buttonLike: buttonLike, favorite: film.favorit)
        
    }

}

//extension UIImage {
//    func resizedImage(newSize: CGSize) -> UIImage {
//        // Guard newSize is different
//        guard self.size != newSize else { return self }
//
//        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
//        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
//        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//        return newImage
//    }
//
//    func resizedImageWithinRect(rectSize: CGSize) -> UIImage {
//        let widthFactor = size.width / rectSize.width
//        let heightFactor = size.height / rectSize.height
//
//        var resizeFactor = widthFactor
//        if size.height > size.width {
//            resizeFactor = heightFactor
//        }
//
//        let newSize = CGSize(width: size.width/resizeFactor, height: size.height/resizeFactor)
//        let resized = resizedImage(newSize: newSize)
//        return resized
//    }
//}

extension UIImage {
    func resizeImage(_ newSize: CGSize) -> UIImage? {
        func isSameSize(_ newSize: CGSize) -> Bool {
            return size == newSize
        }
        
        func scaleImage(_ newSize: CGSize) -> UIImage? {
            func getScaledRect(_ newSize: CGSize) -> CGRect {
                let ratio   = max(newSize.width / size.width, newSize.height / size.height)
                let width   = size.width * ratio
                let height  = size.height * ratio
                return CGRect(x: 0, y: 0, width: width, height: height)
            }
            
            func scaleImage( scaledRect: CGRect) -> UIImage? {
                UIGraphicsBeginImageContextWithOptions(scaledRect.size, false, 0.0);
                draw(in: scaledRect)
                let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
                UIGraphicsEndImageContext()
                return image
            }
            return scaleImage(scaledRect: getScaledRect(newSize))
        }
        
        return isSameSize(newSize) ? self : scaleImage(newSize)!
    }
}
