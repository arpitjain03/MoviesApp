//
//  MoviesDetailColCell.swift
//  MoviesApp
//
//  Created by Arpit Jain on 14/05/21.
//

import UIKit

class MoviesDetailColCell: UICollectionViewCell {

    // MARK: - IB Outlets

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Configuration Methods

    func configure(model: CastModel) {
        imgView.cornerRadius = imgView.frame.height/2
        imgView.setImageUsingKF(string: model.profilePath, placeholder: #imageLiteral(resourceName: "icon-avtar"))
        lblName.text = model.originalName
    }
    
    func configure(model: Movie) {
        imgView.setImageUsingKF(string: model.posterPath, placeholder: #imageLiteral(resourceName: "icon-placeholder.pdf"))
        lblName.text = model.originalTitle
    }
}
