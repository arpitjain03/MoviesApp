//
//  MovieReviewsVC+UITableView.swift
//  MoviesApp
//
//  Created by Arpit Jain on 15/05/21.
//

import UIKit

// MARK: - UITableViewDataSource Methods

extension MovieReviewsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let aCount = (objReviewsVM.objReviewsModel?.results?.count ?? 0)
        lblNoData.isHidden = (aCount > 0)
        return aCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let aCell = tableView.dequeueReusableCell(withClass: MovieReviewsTblCell.self) else { return UITableViewCell() }
        if let aReview = objReviewsVM.objReviewsModel?.results?[indexPath.row] {
            aCell.configure(aReview)
        }
        return aCell
    }
}

// MARK: - UIScrollView Methods

extension MovieReviewsVC {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y >= (scrollView.contentSize.height) - scrollView.frame.size.height {
            
            // Check if you have the Pagination data or not.
            guard let aResultsData = objReviewsVM.objReviewsModel else { return }

            // Request for more data only if the current data count is less than the total number of records on the server.
            if  (aResultsData.totalResults ?? 0) > (aResultsData.results?.count ?? 0) {
                objReviewsVM.updatePageInfo(movieId, (aResultsData.page ?? 0) + 1)
                objReviewsVM.getMovieReviewsList(true) { [weak self] _ in
                    self?.tblView?.reloadData()
                }
            }
        }
    }
}
