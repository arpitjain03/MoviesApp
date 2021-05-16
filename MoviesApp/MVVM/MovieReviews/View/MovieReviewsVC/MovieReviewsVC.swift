//
//  MovieReviewsVC.swift
//  MoviesApp
//
//  Created by Arpit Jain on 15/05/21.
//

import UIKit

class MovieReviewsVC: BaseViewController {

    // MARK: - IB Outlets
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblNoData: UILabel!

    // MARK: - Public Properties
    
    public var movieId: Int?
    public var objReviewsVM = MovieReviewsViewModel()

    // MARK: - View Controller Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewOnDidLoad()
    }
    
    // MARK: - Private Methods

    /// Function to configure view initially
    private func configureViewOnDidLoad() {
        registerNib()
        
        getReviewsList()
    }
 
    /// Function to register Nib
    private func registerNib() {
        tblView.registerNib(withCellClass: MovieReviewsTblCell.self)
        tblView.tableFooterView = UIView()
    }
    
    /// Function to fetch reviews from server
    private func getReviewsList() {
            
        objReviewsVM.updatePageInfo(movieId, 1)
        objReviewsVM.getMovieReviewsList { [weak self] _ in
            self?.tblView?.reloadData()
        }
    }
}
