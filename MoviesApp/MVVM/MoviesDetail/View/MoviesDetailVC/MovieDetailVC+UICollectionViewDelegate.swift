//
//  MovieDetailVC+UICollectionViewDelegate.swift
//  MoviesApp
//
//  Created by Arpit Jain on 14/05/21.
//

import UIKit

extension MoviesDetailVC: UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Navigate to movie details for Similar movies too
        if collectionView == cvSimilarMovies {
            if let movie = objMovieDetailVM.objMoviesModel?.results?[indexPath.row], let aVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllerIDs.movieDetail) as? MoviesDetailVC {
                aVC.movieId = movie.id
                navigationController?.show(aVC, sender: nil)
            }
        }
    }
}
