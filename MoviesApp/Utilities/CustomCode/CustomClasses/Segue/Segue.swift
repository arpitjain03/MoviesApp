//
//  Segue.swift
//  MoviesApp
//
//  Created by Arpit Jain on 14/05/21

import UIKit

struct Segue {

    static let moveToMovieList = "moveToMovieList"

    static let moveToMovieDetails = "moveToMovieDetails"
            
    static let moveToMovieReviews = "moveToMovieReviews"

}

class RootVCSegue: UIStoryboardSegue {
    override func perform() {
        APPDELEGATE.window?.rootViewController = destination
    }
}
