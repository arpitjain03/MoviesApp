//
//  Service.swift
//  MoviesApp
//
//  Created by Arpit Jain on 14/05/21

import UIKit
import Moya

/// Enum to handle all API services
enum MovieServices {
    
    /// User
    case getMovieList(param: [String: Any])
    case getSynopis(param: [String: Any])
    case getMovieReviews(param: [String: Any])
    case getSimilarMovies(param: [String: Any])
    case getGenreList(param: [String: Any])
    case getMovieCredits(param: [String: Any])
}

extension MovieServices: TargetType {
    
    var task: Task {
        
        switch self {

        case .getMovieList(let param),
             .getSynopis(let param),
             .getMovieReviews(let param),
             .getSimilarMovies(let param),
             .getGenreList(let param),
             .getMovieCredits(let param):
            
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        }
    }
    
    /// The headers to be used in the request.
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var baseURL: URL {
        return URL(string: MovieAPI.Server.BASEURL)!
    }
    
    /// MARK: - path
    var path: String {
        switch self {
            
        case .getMovieList:
            return "movie/now_playing"
        case .getSynopis(let param):
            return "movie/\(param[MovieAPI.Request.movieId] ?? "")"
        case .getMovieReviews(let param):
            return "movie/\(param[MovieAPI.Request.movieId] ?? "")/reviews"
        case .getSimilarMovies(let param):
            return "movie/\(param[MovieAPI.Request.movieId] ?? "")/similar"
        case .getGenreList:
            return "genre/movie/list"
        case .getMovieCredits(let param):
            return "movie/\(param[MovieAPI.Request.movieId] ?? "")/credits"
        }
    }
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        default:
            return URLEncoding.default
        }
    }
    
    var sampleData: Data {
        return Data()
    }
}
