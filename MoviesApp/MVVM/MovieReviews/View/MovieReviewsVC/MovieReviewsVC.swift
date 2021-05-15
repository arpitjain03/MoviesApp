//
//  MovieReviewsVC.swift
//  MoviesApp
//
//  Created by Arpit Jain - IndiaNIC on 15/05/21.
//

import UIKit

class MovieReviewsVC: BaseViewController {

    // MARK: - IB Outlets
    
    @IBOutlet weak var tblView: UITableView!
    
    // MARK: - Public Properties
    
    public var movieId: Int?
    
    // MARK: - View Controller Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewOnDidLoad()
    }
    
    // MARK: - Private Methods

    /// Function to configure view initially
    private func configureViewOnDidLoad() {
        registerNib()
    }
 
    /// Function to register Nib
    private func registerNib() {
        tblView.registerNib(withCellClass: MovieReviewsTblCell.self)
    }
}
