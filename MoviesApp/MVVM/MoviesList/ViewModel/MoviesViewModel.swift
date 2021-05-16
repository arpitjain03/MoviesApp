//
//  MoviesViewModel.swift
//  MoviesApp
//
//  Created by Arpit Jain on 14/05/21.
//

import Foundation

class MoviesViewModel: NSObject {
    
    // MARK: - Public Properties
        
    public private(set) var objMoviesModel: MovieModel?
    
    public private(set) var objGenreModel: GenreModel?

    public private(set) var arrFilteredMovies = [Movie]()

    public private(set) var arrRecentSearches = [RecentSearches]()
    
    // MARK: - Private Properties
    
    private var objRequestModel = MovieListRequestModel()
    
    private var isAPICalling: Bool = false
    
    // MARK: - Public Methods

    /// Function to call Movies List API with pagination
    /// - Parameters:
    ///   - isSilent: pass true for silent call
    ///   - completion: gives callback for success
    public func getMoviesList(_ isSilent: Bool = false, completion: @escaping (Bool) -> Void) {
        
        if isAPICalling { return }
        
        let aParam = [MovieAPI.Request.apiKey: AppKeys.movieDbApiKey,
                      MovieAPI.Request.language: AppConstant.language,
                      MovieAPI.Request.page: objRequestModel.page] as [String: Any]
        
        let aService = MovieServices.getMovieList(param: aParam)
        
        isAPICalling = true
        
        // Call the API background thread.
        DispatchQueue.global(qos: .utility).async {
            Network.request(target: aService, isSilent: isSilent, resultType: MovieModel.self) { [weak self] (result) in
                
                self?.isAPICalling = false
                
                // Process the repsonse on the Main thread
                DispatchQueue.main.async {
                    switch result {
                    
                    case .success(let response, let isSuccess):
                        if isSuccess, let aResponseModel = response as? MovieModel {
                            
                            if self?.objRequestModel.page == 1 {
                                self?.objMoviesModel = nil
                            }
                            
                            // Manage the received data for Pagination.
                            if let aExistingData = self?.objMoviesModel {
                                // Current model has the data available.
                                
                                // Append new data with the previous pagination data.
                                if aExistingData.results?.isEmpty ?? true {
                                    // Previous data is not available.
                                    self?.objMoviesModel?.results = aResponseModel.results
                                } else {
                                    // Previous data is available. Append the data.
                                    self?.objMoviesModel?.results?.append(contentsOf: aResponseModel.results ?? [])
                                }
                                // Replace the Pagination Model.
                                self?.objMoviesModel?.totalResults = aResponseModel.totalResults
                                self?.objMoviesModel?.page = aResponseModel.page
                                
                            } else {
                                // Current model do not have the data available.
                                // Store the current received data directly.
                                self?.objMoviesModel = aResponseModel
                            }
                            completion(true)
                        } else {
                            // Display Error
                            completion(false)
                        }
                    case .failure:
                        completion( false)
                    }
                }
            }
        }
    }
    
    // *************************************************************//
    // SEARCH IMPLEMENTATION ( Filter data locally on Movies List)
    // *************************************************************//
    
    /// Function to get search results
    /// - Parameter completion: gives callback for success
    public func getSearchResults(completion: @escaping () -> Void) {
        
        if let arrMovies = objMoviesModel?.results {
            
            arrFilteredMovies = arrMovies.filter { (aMovie) in
                if let aArrStr = aMovie.originalTitle?.split(separator: " ") {
                    for aStr in aArrStr where aStr.lowercased().hasPrefix(objRequestModel.searchText.lowercased()) {
                        return true
                    }
                }
                return false
            }
            completion()
        }
    }
    
    /// Function to call API for Genre List
    public func getGenreList() {
        
        let aParam = [MovieAPI.Request.apiKey: AppKeys.movieDbApiKey,
                      MovieAPI.Request.language: AppConstant.language]
        
        let aService = MovieServices.getGenreList(param: aParam)
        
        // Call the API background thread.
        DispatchQueue.global(qos: .utility).async {
            Network.request(target: aService, isSilent: true, resultType: GenreModel.self) { [weak self] (result) in
                
                self?.isAPICalling = false
                
                // Process the repsonse on the Main thread
                DispatchQueue.main.async {
                    switch result {
                    
                    case .success(let response, let isSuccess):
                        if isSuccess, let aResponseModel = response as? GenreModel {
                            self?.objGenreModel = aResponseModel
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    /// Function to Get Recent Searches from our local database
    /// - Parameter completion: gives callback for success
    public func getRecentSearches(completion: @escaping () -> Void) {
     
        CoreDataManager.shared.fetchData(entity: Entity.RecentSearches, updatePredicate: nil) { (_, records, _) in
            
            if (records?.count ?? 0) > 0, let aRecords = records as? [RecentSearches] {
                arrRecentSearches = aRecords
                completion()
            }
        }
    }
    
    /// Function to save recent search object to our local database
    /// - Parameter movie: pass movie object
    public func saveRecentSearchData(_ movie: Movie) {
        
        // If array count exceeds 5 then remove last record from Database
        if arrRecentSearches.count >= 5 {
            if let lastRecord = arrRecentSearches.last {
                CoreDataManager.shared.deleteData(record: lastRecord) { (_, _) in }
            }
        }
        // Check if record for movieId is available or not
        CoreDataManager.shared.fetchData(entity: Entity.RecentSearches, updatePredicate: "movieId == \(movie.id ?? 0)") { (_, records, _) in
        
            let aContext = CoreDataManager.shared.persistentContainer.viewContext
            let aObj = RecentSearches(context: aContext)
            aObj.movieId = movie.id?.description
            aObj.originalTitle = movie.originalTitle
            aObj.posterPath = movie.posterPath

            if records?.count == 0 {
                // If record is not available adding new entry in database
                CoreDataManager.shared.saveData { (_, _) in
                    getRecentSearches { }
                }
            } else {
                // If record is available remove and re-add in database to maintain sorting
                if let lastRecord = records?.first {
                    CoreDataManager.shared.deleteData(record: lastRecord) { (_, _) in }
                }
                CoreDataManager.shared.saveData { (_, _) in
                    getRecentSearches { }
                }
            }
        }
    }
}

// MARK: - Validation and Request Related Methods

extension MoviesViewModel {
    
    /// Function to reset response model
    func reset() {
        objMoviesModel = nil
        objRequestModel.page = 1
        objRequestModel.searchText = ""
    }
    
    /// Function to update page info
    /// - Parameter page: pass page number
    func updatePageInfo(_ page: Int) {
        objRequestModel.page = page
    }
    
    func updateSearch(_ search: String) {
        objRequestModel.searchText = search
    }
}
