//
//  APIManager.swift
//  MoviesApp
//
//  Created by Arpit Jain on 14/05/21

import UIKit
import Alamofire
import Moya

struct AlamofireManager {
    
    static let shared: Session = {
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 90.0           // Seconds
        configuration.timeoutIntervalForResource = 90.0          // Seconds
        
        return Alamofire.Session(configuration: configuration)
        
    }()
}

#if DEBUG
let provider = MoyaProvider<MovieServices>(session: AlamofireManager.shared,
                                     plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])
#else
let provider = MoyaProvider<Service>(session: AlamofireManager.shared)
#endif

/// Class to handle network calls in Application
class Network {
    
    typealias Completion<T: Codable> = (Results<Any?, Bool>) -> Void

    /// Function to setup request from Api call using Moya
    /// - Parameters:
    ///   - target: pass service object
    ///   - isSilent: pass true for silent API calls
    ///   - resultType: pass the expected model type
    ///   - completion: gets completion after API success
    /// - Returns: 
    @discardableResult
    class func request<T: Codable>(target: MovieServices, isSilent: Bool = false, resultType: T.Type?, completion: @escaping Completion<T?>) -> Cancellable {
        
        if !isSilent {
            ActivityIndicator.show()
        }
        
        return provider.request(target) { (result) in
            switch result {
            
            case .success(let response):
                if !isSilent {
                    ActivityIndicator.hide()
                }
                switch response.statusCode {
                case 200:
                    // Greater or equal than 200 and less or equal than 300
                    let data = try? JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(data, true))

                default:
                    let data = try? JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(data, false))
                }
            case .failure(let error):
                
                ActivityIndicator.hide()
                completion(.failure(error))
            }
        }
    }
    
}

enum Results<Value, Bool> {
    case success(Value, Bool)
    case failure(Error)
}
