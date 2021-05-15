//
//  MovieReviewsVC+UITableView.swift
//  MoviesApp
//
//  Created by Arpit Jain on 15/05/21.
//

import UIKit

extension MovieReviewsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let aCell = tableView.dequeueReusableCell(withClass: MovieReviewsTblCell.self) else { return UITableViewCell() }
        return aCell
    }
}
