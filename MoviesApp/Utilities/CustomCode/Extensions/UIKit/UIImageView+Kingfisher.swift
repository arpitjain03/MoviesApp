//
//  UIImageView+Kingfisher.swift
//  MoviesApp
//
//  Created by Arpit Jain on 14/05/21.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    /// - Util function to add image with caching
    func setImageUsingKF(string: String?, placeholder: UIImage?) {
        ///  ====  Append base media path here
        let updatedString = AppConstant.imageBaseURL + (string ?? "")
        self.kf.setImage(with: URL(string: updatedString), placeholder: placeholder, options: [.cacheOriginalImage, .transition(.fade(0.2))])
    }
    
    /// - Util function to add image with caching
    func setImageKF(string: String?, placeholder: UIImage?) {
        self.kf.setImage(with: URL(string: string ?? ""), placeholder: placeholder, options: [.cacheOriginalImage, .transition(.fade(0.2))])
    }
}
