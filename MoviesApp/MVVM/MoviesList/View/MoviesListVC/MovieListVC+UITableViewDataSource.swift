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
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isSearchActive {
            guard let aCell = tableView.dequeueReusableCell(withClass: MovieSearchTblCell.self) else { return UITableViewCell() }
            return aCell
        } else {
            guard let aCell = tableView.dequeueReusableCell(withClass: MovieListTblCell.self) else { return UITableViewCell() }
            return aCell
        }
    }
}

// MARK: - UIScrollView Methods

extension MoviesListVC {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y >= (scrollView.contentSize.height) - scrollView.frame.size.height {
            print("Load more API call comes here")
        }
    }
}
