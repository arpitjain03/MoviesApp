//
//  MovieReviewsTblCell.swift
//  MoviesApp
//
//  Created by Arpit Jain on 15/05/21.
//

import UIKit

class MovieReviewsTblCell: UITableViewCell {

    // MARK: - IB Outlets
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblRatedAt: UILabel!
    @IBOutlet weak var lblReview: UILabel!
    @IBOutlet weak var imgViewUser: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(_ model: Review) {
        
        lblName.text = model.author
        if let rating = model.authorDetails?.rating {
            lblRating.text = rating.description
        } else {
            lblRating.text = "0.0"
        }
        lblReview.text = model.content
        
        // From server URL not coming proper string has extra / at startIndex.
        // So need to remove it manually
        let avatarPath = model.authorDetails?.avatarPath ?? ""
        let newString = String(avatarPath.dropFirst())
        imgViewUser.setImageKF(string: newString, placeholder: PlaceHolderImages.avatar)
        
        lblRatedAt.text = model.createdAt?.getDateAsAgo()
    }
    
}
