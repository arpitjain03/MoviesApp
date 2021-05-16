//
//  MovieReviewsViewModel.swift
//  MoviesApp
//
//  Created by Arpit Jain on 15/05/21.
//

import UIKit

class MovieReviewsViewModel: NSObject {

    // MARK: - Public Properties
        
    public private(set) var objReviewsModel: MovieReviewsModel?
        
    // MARK: - Private Properties
    
    private var objRequestModel = MovieReviewRequestModel()
    
    private var isAPICalling: Bool = false
    
    // MARK: - Public Methods

    /// Function to call Movie Reviews List API with pagination
    /// - Parameters:
    ///   - isSilent: pass true for silent call
    ///   - completion: gives callback for success
    public func getMovieReviewsList(_ isSilent: Bool = false, completion: @escaping (Bool) -> Void) {
        
        if isAPICalling { return }
        
        let aParam = [MovieAPI.Request.apiKey: AppKeys.movieDbApiKey,
                      MovieAPI.Request.language: AppConstant.language,
                      MovieAPI.Request.page: objRequestModel.page,
                      MovieAPI.Request.movieId: objRequestModel.movieId] as [String: Any]
        
        let aService = MovieServices.getMovieReviews(param: aParam)
        
        isAPICalling = true
        
        // Call the API background thread.
        DispatchQueue.global(qos: .utility).async {
            Network.request(target: aService, isSilent: isSilent, resultType: MovieReviewsModel.self) { [weak self] (result) in
                
                self?.isAPICalling = false
                
                // Process the repsonse on the Main thread
                DispatchQueue.main.async {
                    switch result {
                    
                    case .success(let response, let isSuccess):
                        if isSuccess, let aResponseModel = response as? MovieReviewsModel {
                            
                            if self?.objRequestModel.page == 1 {
                                self?.objReviewsModel = nil
                            }
                            
                            // Manage the received data for Pagination.
                            if let aExistingData = self?.objReviewsModel {
                                // Current model has the data available.
                                
                                // Append new data with the previous pagination data.
                                if aExistingData.results?.isEmpty ?? true {
                                    // Previous data is not available.
                                    self?.objReviewsModel?.results = aResponseModel.results
                                } else {
                                    // Previous data is available. Append the data.
                                    self?.objReviewsModel?.results?.append(contentsOf: aResponseModel.results ?? [])
                                }
                                // Replace the Pagination Model.
                                self?.objReviewsModel?.totalResults = aResponseModel.totalResults
                                self?.objReviewsModel?.page = aResponseModel.page
                                
                            } else {
                                // Current model do not have the data available.
                                // Store the current received data directly.
                                self?.objReviewsModel = aResponseModel
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

}

// MARK: - Validation and Request Related Methods

extension MovieReviewsViewModel {
    
    /// Function to reset response model
    func reset() {
        objReviewsModel = nil
        objRequestModel.page = 1
    }
    
    /// Function to update page info
    /// - Parameter page: pass page number
    func updatePageInfo(_ movieId: Int?, _ page: Int) {
        objRequestModel.movieId = movieId ?? 0
        objRequestModel.page = page
    }
}
