//
//  CellDetailsTableViewCell.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 28/11/18.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageBanner: UIImageView!
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var viewPlay: UIView!
    @IBOutlet weak var viewIMDB: UIView!
    @IBOutlet weak var labelFilmName: UILabel!
    @IBOutlet weak var labelGeneres: UILabel!
    @IBOutlet weak var labelNote: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelDirector: UILabel!
    @IBOutlet weak var labelWriter: UILabel!
    @IBOutlet weak var buttonLike: UIButton!
    @IBOutlet weak var ImageAquired: UIImageView!
    @IBOutlet weak var labelSynopsis: UILabel!
    
    
    let detailsCellViewModel = DetailsCellViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureBorders() {
        detailsCellViewModel.configureBorders(imagePoster: imagePoster, viewPlay: viewPlay, viewIMDB: viewIMDB)
    }
    
    func setFilmDetails(id: Int) {
        detailsCellViewModel.setFilmDetails(id: id)
    }
    
}
