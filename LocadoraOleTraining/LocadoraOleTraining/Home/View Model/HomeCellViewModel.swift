//
//  HomeCellViewModel.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 05/11/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import Foundation

class HomeCellViewModel {
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
    
    func setFilmInformations() {
        
    }
    
    
}
