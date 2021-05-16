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
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var imgViewThumb: UIImageView!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblLanguages: UILabel!
    @IBOutlet weak var lblSynposis: UILabel!
    @IBOutlet weak var lblSimilarMoviesTitle: UILabel!
    @IBOutlet weak var cvCredits: UICollectionView!
    @IBOutlet weak var cvSimilarMovies: UICollectionView!
    
    @IBOutlet weak var cvMoviesHeightConstraint: NSLayoutConstraint!

    // MARK: - Public Properties

    public var movieId: Int?
    
    public var objMovieDetailVM = MovieDetailViewModel()

    // MARK: - View Controller Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewOnDidLoad()
    }
    
    // MARK: - Public Methods

    /// Function to show hide similar movies
    /// - Parameter hide: pass true for  hide
    public func showHideSimilarMovies(_ hide: Bool) {
        if hide {
            lblSimilarMoviesTitle.isHidden = true
            cvMoviesHeightConstraint.constant = 0
        } else {
            lblSimilarMoviesTitle.isHidden = false
            cvMoviesHeightConstraint.constant = 135
        }
    }
    
    /// Function to register Nib
    public func registerNib() {
        cvCredits.registerNib(withCellClass: MoviesDetailColCell.self)
        cvSimilarMovies.registerNib(withCellClass: MoviesDetailColCell.self)
    }
    
    // MARK: - Private Methods

    /// Function to configure view initially
    private func configureViewOnDidLoad() {
        registerNib()

        objMovieDetailVM.updateMovieInfo(movieId ?? 0)
        
        objMovieDetailVM.getSynopisData { [weak self] in
            self?.setupMovieData()
        }
        
        objMovieDetailVM.getSimilarMovies { [weak self] in
            self?.cvSimilarMovies.reloadData()
        }
        
        objMovieDetailVM.getCreditsList { [weak self] in
            self?.cvCredits.reloadData()
        }
    }
    
    /// Function to setup movie details in UI
    private func setupMovieData() {
        if let movie = objMovieDetailVM.objSynopsisModel {
            
            lblMovieTitle.text = movie.originalTitle
            imgViewCover.setImageUsingKF(string: movie.backdropPath, placeholder: #imageLiteral(resourceName: "icon-placeholder.pdf"))
            imgViewThumb.setImageUsingKF(string: movie.posterPath, placeholder: #imageLiteral(resourceName: "icon-placeholder.pdf"))
            
            lblGenre.text = movie.genres?.compactMap({ $0.name }).joined(separator: " • ")
            lblLanguages.text = movie.spokenLanguages?.compactMap({ $0.englishName }).joined(separator: " • ")
            
            lblSynposis.text = movie.overview
            
            lblRating.text = movie.voteAverage?.description
            
            let minutes = movie.runtime ?? 0
            let strHm = "\(minutes / 60)h \(minutes % 60)m"
            lblTime.text = strHm
        }
    }
    
    // MARK: - Button Action Methods

    @IBAction func btnReviewsTapped(_ sender: Any) {
        self.performSegue(withIdentifier: Segue.moveToMovieReviews, sender: movieId)
    }
}

extension MoviesDetailVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let aVC = segue.destination as? MovieReviewsVC {
            aVC.movieId = movieId
        }
    }
}
