//
//  MovieDetailVC+UICollectionViewDatasource.swift
//  MoviesApp
//
//  Created by Arpit Jain on 14/05/21.
//

import UIKit

extension MoviesDetailVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let aCell = collectionView.dequeueReusableCell(withClass: MoviesDetailColCell.self, for: indexPath) else { return UICollectionViewCell()
        }
        return aCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
}
