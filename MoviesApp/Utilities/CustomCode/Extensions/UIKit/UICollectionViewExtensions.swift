//
//  UICollectionViewExtensions.swift
//  MoviesApp
//
//  Created by Arpit Jain on 14/05/21.
//

import UIKit

extension UICollectionView {
    
    /// Register UICollectionViewCell using class name
    ///
    /// - Parameters:
    ///   - name: UICollectionViewCell type.
    func registerNib<T: UICollectionViewCell>(withCellClass name: T.Type) {
        register(UINib(nibName: String(describing: name), bundle: Bundle.main), forCellWithReuseIdentifier: String(describing: name))
    }
    
    /// SwiferSwift: Dequeue reusable UICollectionViewCell using class name for indexPath
    ///
    /// - Parameters:
    ///   - name: UICollectionViewCell type.
    ///   - indexPath: location of cell in collectionView.
    /// - Returns: UICollectionViewCell object with associated class name.
    func dequeueReusableCell<T: UICollectionViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: String(describing: name), for: indexPath) as? T
    }
    
}
