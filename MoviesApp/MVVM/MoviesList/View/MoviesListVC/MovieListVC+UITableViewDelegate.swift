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
        self.performSegue(withIdentifier: Segue.moveToMovieDetails, sender: nil)
    }
}
