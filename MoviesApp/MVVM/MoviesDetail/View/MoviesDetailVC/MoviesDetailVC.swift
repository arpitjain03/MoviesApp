//
//  MoviesDetailVC.swift
//  MoviesApp
//
//  Created by Arpit Jain on 14/05/21.
//

import UIKit

class MoviesDetailVC: BaseViewController {

    // MARK: - IB Outlets

    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var imgViewCover: UIImageView!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var imgViewThumb: UIImageView!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblLanguages: UILabel!
    @IBOutlet weak var lblSynposis: UILabel!
    @IBOutlet weak var lblSimilarMoviesTitle: UILabel!
    @IBOutlet weak var cvCredits: UICollectionView!
    @IBOutlet weak var cvSimilarMovies: UICollectionView!
    
    // MARK: - Public Properties

    public var movieId: Int?
    
    public var objMovieDetailVM = MovieDetailViewModel()

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
        cvCredits.registerNib(withCellClass: MoviesDetailColCell.self)
        cvSimilarMovies.registerNib(withCellClass: MoviesDetailColCell.self)
    }
}
