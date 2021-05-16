//
//  MovieListVC+UITableViewDelegate.swift
//  MoviesApp
//
//  Created by Arpit Jain on 14/05/21.
//

import UIKit

// MARK: - UITableViewDelegate Methods

extension MoviesListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var movieId: Int?
       
        if isSearchActive {
            if objSearchBar.text?.isEmpty ?? false && objMoviesVM.arrRecentSearches.count > 0 {
                // -- When search is active & searchText is empty use recent searches object -- //
                movieId = Int(objMoviesVM.arrRecentSearches[indexPath.row].movieId ?? "")
           
            } else if objMoviesVM.arrFilteredMovies.count > 0 {
                // -- When search is active & array filter has count use filtered array -- //
                movieId = objMoviesVM.arrFilteredMovies[indexPath.row].id
                objMoviesVM.saveRecentSearchData(objMoviesVM.arrFilteredMovies[indexPath.row])
            }
        } else {
            // -- When search is not active use movies array object -- //
            movieId = objMoviesVM.objMoviesModel?.results?[indexPath.row].id
        }
        
        // -- When selecting any movie update UI to movie list -- //
        isSearchActive = false
        tblViewList.reloadData()
        
        // Navigation to Movies Detail Page
        self.performSegue(withIdentifier: Segue.moveToMovieDetails, sender: movieId)
    }
}
