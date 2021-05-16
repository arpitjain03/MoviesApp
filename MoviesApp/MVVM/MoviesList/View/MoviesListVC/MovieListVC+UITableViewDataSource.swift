//
//  MovieListVc+UITableViewDataSource.swift
//  MoviesApp
//
//  Created by Arpit Jain on 14/05/21.
//

import UIKit

// MARK: - UITableViewDataSource Methods

extension MoviesListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // -- Pass count based on searchBar status -- //
        var count = 0
        if isSearchActive {
            if objSearchBar.text?.isEmpty ?? false && objMoviesVM.arrRecentSearches.count > 0 {
                count = objMoviesVM.arrRecentSearches.count 
            } else {
                count = objMoviesVM.arrFilteredMovies.count
            }
        } else {
            count = (objMoviesVM.objMoviesModel?.results?.count ?? 0)
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let aCell = tableView.dequeueReusableCell(withClass: MovieListTblCell.self) else { return UITableViewCell() }
        
        if isSearchActive {
            
            if objSearchBar.text?.isEmpty ?? false && objMoviesVM.arrRecentSearches.count > 0 {
                
                // -- When search is active & searchText is empty load MovieSearchTblCell -- //
                guard let aSearchCell = tableView.dequeueReusableCell(withClass: MovieSearchTblCell.self) else { return UITableViewCell() }
                aSearchCell.lblTitle.text = objMoviesVM.arrRecentSearches[indexPath.row].originalTitle
                return aSearchCell
                
            } else if objMoviesVM.arrFilteredMovies.count > 0 {
                
                // -- When search is active & array filter has count MovieListTblCell with Filter data -- //
                let movie = objMoviesVM.arrFilteredMovies[indexPath.row]
                aCell.configure(model: movie)
                aCell.lblGenre.text = getGenresFromIds(movie)
            }
        } else {
            // -- When search is not active use MovieListTblCell with movies array object -- //
            if let movie = objMoviesVM.objMoviesModel?.results?[indexPath.row] {
                aCell.configure(model: movie)
                aCell.lblGenre.text = getGenresFromIds(movie)
            }
        }
        return aCell
    }
}

// MARK: - UIScrollView Methods

extension MoviesListVC {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y >= (scrollView.contentSize.height) - scrollView.frame.size.height {
            
            // Check if search is active return as we are performing local search
            if isSearchActive { return }
            
            // Check if you have the Pagination data or not.
            guard let aResultsData = objMoviesVM.objMoviesModel else { return }

            // Request for more data only if the current data count is less than the total number of records on the server.
            if  (aResultsData.totalResults ?? 0) > (aResultsData.results?.count ?? 0) {
                objMoviesVM.updatePageInfo((aResultsData.page ?? 0) + 1)
                objMoviesVM.getMoviesList(true) { [weak self] _ in
                    self?.tblViewList?.reloadData()
                }
            }
        }
    }
}
