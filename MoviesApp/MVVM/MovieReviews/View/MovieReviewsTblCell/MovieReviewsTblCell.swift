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
    
}
