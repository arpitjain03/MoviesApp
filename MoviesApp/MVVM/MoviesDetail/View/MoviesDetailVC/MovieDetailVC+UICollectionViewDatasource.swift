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
        if collectionView == cvCredits {
            // -- Use cast object if collection view is cvCredits -- //
            if let cast = objMovieDetailVM.objCreditsModel?.cast?[indexPath.row] {
                aCell.configure(model: cast)
            }
        } else {
            // -- Use result object if collection view is cvSimilarMovies -- //
            if let movie = objMovieDetailVM.objMoviesModel?.results?[indexPath.row] {
                aCell.configure(model: movie)
            }
        }
        return aCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // -- Return number of Items based on collection view type -- //
        if collectionView == cvCredits {
            return (objMovieDetailVM.objCreditsModel?.cast?.count ?? 0)
        } else {
            let count = (objMovieDetailVM.objMoviesModel?.results?.count ?? 0)
            // -- Hide similar movies if count is 0 -- //
            showHideSimilarMovies(count == 0)
            return count
        }
    }
}
