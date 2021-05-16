//
//  MovieDetailViewModel.swift
//  MoviesApp
//
//  Created by Arpit Jain on 14/05/21.
//

import UIKit

class MovieDetailViewModel: NSObject {
    
    // MARK: - Public Properties
    
    public private(set) var objSynopsisModel: SynopsisModel?
    public private(set) var objCreditsModel: CreditsModel?
    public private(set) var objMoviesModel: MovieModel?

    // MARK: - Private Properties

    private var objRequestModel = MovieDetailRequestModel()
    
    // MARK: - Public Methods

    /// Function to call API to fetch Synopsis data from server
    /// - Parameter completion: gives callback for success
    public func getSynopisData(completion: @escaping () -> Void) {
        
        let aParam = [MovieAPI.Request.apiKey: AppKeys.movieDbApiKey,
                      MovieAPI.Request.language: AppConstant.language,
                      MovieAPI.Request.movieId: objRequestModel.movieId] as [String: Any]
        
        let aService = MovieServices.getSynopis(param: aParam)
        
        // Call the API background thread.
        DispatchQueue.global(qos: .utility).async {
            Network.request(target: aService, isSilent: false, resultType: SynopsisModel.self) { [weak self] (result) in
                                
                // Process the repsonse on the Main thread
                DispatchQueue.main.async {
                    switch result {
                    
                    case .success(let response, let isSuccess):
                        if isSuccess, let aResponseModel = response as? SynopsisModel {
                            self?.objSynopsisModel = aResponseModel
                            completion()
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    /// Function to call API to fetch Credits data from server
    /// - Parameter completion: gives callback for success
    public func getCreditsList(completion: @escaping () -> Void) {
        
        let aParam = [MovieAPI.Request.apiKey: AppKeys.movieDbApiKey,
                      MovieAPI.Request.language: AppConstant.language,
                      MovieAPI.Request.movieId: objRequestModel.movieId] as [String: Any]
        
        let aService = MovieServices.getMovieCredits(param: aParam)
        
        // Call the API background thread.
        DispatchQueue.global(qos: .utility).async {
            Network.request(target: aService, isSilent: true, resultType: CreditsModel.self) { [weak self] (result) in
                                
                // Process the repsonse on the Main thread
                DispatchQueue.main.async {
                    switch result {
                    
                    case .success(let response, let isSuccess):
                        if isSuccess, let aResponseModel = response as? CreditsModel {
                            self?.objCreditsModel = aResponseModel
                            completion()
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    /// Function to call API to fetch Similar Movies data from server
    /// - Parameter completion: gives callback for success
    public func getSimilarMovies(completion: @escaping () -> Void) {
        
        let aParam = [MovieAPI.Request.apiKey: AppKeys.movieDbApiKey,
                      MovieAPI.Request.language: AppConstant.language,
                      MovieAPI.Request.movieId: objRequestModel.movieId] as [String: Any]
        
        let aService = MovieServices.getSimilarMovies(param: aParam)
        
        // Call the API background thread.
        DispatchQueue.global(qos: .utility).async {
            Network.request(target: aService, isSilent: true, resultType: MovieModel.self) { [weak self] (result) in
                
                // Process the repsonse on the Main thread
                DispatchQueue.main.async {
                    switch result {
                    
                    case .success(let response, let isSuccess):
                        if isSuccess, let aResponseModel = response as? MovieModel {
                            self?.objMoviesModel = aResponseModel
                            completion()
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

// MARK: - Validation and Request Related Methods

extension MovieDetailViewModel {
    
    /// Function to update movie id
    /// - Parameter page: pass movieId
    func updateMovieInfo(_ movieId: Int) {
        objRequestModel.movieId = movieId
    }

}
