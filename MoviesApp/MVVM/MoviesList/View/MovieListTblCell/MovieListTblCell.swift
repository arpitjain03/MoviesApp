//
//  MovieListTblCell.swift
//  MoviesApp
//
//  Created by Arpit Jain on 14/05/21.
//

import UIKit

class MovieListTblCell: UITableViewCell {

    // MARK: - IBOutlet

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Configuration Methods

    func configure(model: Movie) {
        lblMovieName.text = model.originalTitle
        lblReleaseDate.text = model.releaseDate
        lblRating.text = model.voteAverage?.description
        imgView.setImageUsingKF(string: model.posterPath, placeholder: nil)
    }
}
