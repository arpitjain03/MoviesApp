//
//  ViewController.swift
//  MoviesApp
//
//  Created by Arpit Jain on 14/05/21.
//

import UIKit

class MoviesListVC: BaseViewController {

    // MARK: - IBOutlet

    @IBOutlet weak var tblViewList: UITableView!
    @IBOutlet weak var objSearchBar: UISearchBar!
    @IBOutlet weak var lblRecentSearch: UILabel!
    @IBOutlet weak var btnCancel: UIButton!

    // MARK: - Public Properties

    public var objMoviesVM = MoviesViewModel()
    public var isSearchActive = false

    // MARK: - Private Properties

    private let refreshControl = UIRefreshControl()
    
    // MARK: - View Controller Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        configureOnViewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        hideShowRecentSearch(true)
    }
    
    // MARK: - Private Methods

    /// Function to configire view initially
    private func configureOnViewDidLoad() {
        setupSearchBar()
        
        tblViewList.addSubview(refreshControl)
        
        // Configure Refresh Control
        refreshControl.tintColor = #colorLiteral(red: 0.5529411765, green: 0.5333333333, blue: 0.5333333333, alpha: 1)
        refreshControl.addTarget(self, action: #selector(refreshMoviesList), for: .valueChanged)
        
        registerNib()

        objMoviesVM.getRecentSearches { }
        
        objMoviesVM.getGenreList()

        getMoviesList()
        
    }
    
    /// Function to refresh Movies List
    @objc private func refreshMoviesList() {
        objSearchBar.text = ""
        isSearchActive = false
        objMoviesVM.reset()
        getMoviesList(isSilent: true)
    }
    
    /// Function to configure search bar
    private func setupSearchBar() {
        if let textfield = objSearchBar.value(forKey: "searchField") as? UITextField {
            textfield.font = UIFont(type: .semiBold, size: 16.0)
            textfield.textColor = UIColor.white
        }
    }
    
    /// Function to register table view XIBs
    private func registerNib() {
        tblViewList.registerNib(withCellClass: MovieListTblCell.self)
        tblViewList.registerNib(withCellClass: MovieSearchTblCell.self)

    }
    
    /// Function to fecth movies from server
    private func getMoviesList(isSilent: Bool = false) {
            
        objMoviesVM.updatePageInfo(1)
        objMoviesVM.getMoviesList(isSilent) { [weak self] _ in
            self?.tblViewList?.reloadData()
            self?.refreshControl.endRefreshing()
        }
    }
    
    // MARK: - Public Methods

    /// Function to get Genre name from ids
    /// - Parameter movie: pass object of movie here
    /// - Returns: return Genre string
    public func getGenresFromIds(_ movie: Movie) -> String {
        
        var aTempArray = [Genre]()
        _ = movie.genreIDS?.map({
            let aID = $0
            _ = objMoviesVM.objGenreModel?.genres?.map({
                if ($0.id ?? 0) == aID {
                    aTempArray.append($0)
                }
            })
        })
        return aTempArray.map({ ($0.name ?? "") }).joined(separator: " • ")
    }
    
    /// Function to manage recent searches
    public func manageRecentSearch() {
        if isSearchActive && objSearchBar.text?.isEmpty ?? false {
            hideShowRecentSearch(false)
        } else {
            hideShowRecentSearch(true)
        }
        tblViewList.reloadData()
    }
    
    /// Function to hide/show recent search UI
    /// - Parameter hide: pass true for hide
    public func hideShowRecentSearch(_ hide: Bool) {
        lblRecentSearch.isHidden = hide
        btnCancel.isHidden = hide
    }
    
    // MARK: - Button Action Methods

    @IBAction func btnCancelTapped(_ sender: Any) {
        isSearchActive = false
        view.endEditing(true)
        manageRecentSearch()
    }
}

// MARK: - UISearchBarDelegate Methods

extension MoviesListVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        objMoviesVM.updateSearch(searchText)
        objMoviesVM.getSearchResults { [weak self] in
            self?.manageRecentSearch()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearchActive = true
        manageRecentSearch()
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = ""
        isSearchActive = false
        manageRecentSearch()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        view.endEditing(true)
        isSearchActive = false
        manageRecentSearch()
    }

}

// MARK: - UIStoryboardSegue Methods

extension MoviesListVC {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let aVC = segue.destination as? MoviesDetailVC, let movieId = sender as? Int {
            aVC.movieId = movieId
        }
    }
}

// MARK: - UITouch Methods

extension MoviesListVC {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}
