//
//  APIConstant.swift
//  MoviesApp
//
//  Created by Arpit Jain on 14/05/21


import Foundation

/// This is the Structure for API
internal struct MovieAPI {
    
    // MARK: - API URL
    
    /// Structure for URL. This will have the API end point for the server.
    struct Server {

        /// API
        static let BASEURL                     = "https://api.themoviedb.org/3/"
    }
    
    // MARK: - Basic Response keys
    
    /// Structure for API Response Keys. This will use to get the data or anything based on the key from the repsonse. Do not directly use the key rather define here and use it.
    struct Response {
        
        /// API Base
        static let statusMessage               = "status_message"
        static let results                     = "results"
    }
    
    // MARK: - Request end points

    /// Structure for API Request/Method. Define any of your API endpoint/method here.
    struct Request {

        static let movieId                    = "movieId"
        static let page                       = "page"
        static let language                   = "language"
        static let apiKey                     = "api_key"
    }
}
