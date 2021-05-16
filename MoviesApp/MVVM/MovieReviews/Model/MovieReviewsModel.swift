//
//  MovieReviewsModel.swift
//  MoviesApp
//
//  Created by Arpit Jain on 15/05/21.
//

import Foundation

// MARK: - MovieReviewsModel
struct MovieReviewsModel: Codable {
    var id, page: Int?
    var results: [Review]?
    var totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case id, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Review: Codable {
    let author: String?
    let authorDetails: AuthorDetails?
    let content, createdAt, id, updatedAt: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
        case url
    }
}

// MARK: - AuthorDetails
struct AuthorDetails: Codable {
    let name, username, avatarPath: String?
    let rating: Float?

    enum CodingKeys: String, CodingKey {
        case name, username
        case avatarPath = "avatar_path"
        case rating
    }
}
