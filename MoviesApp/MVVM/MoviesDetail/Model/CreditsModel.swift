//
//  CreditsModel.swift
//  MoviesApp
//
//  Created by Arpit Jain on 14/05/21.
//

import Foundation

// MARK: - CreditsModel
struct CreditsModel: Codable {
    let id: Int?
    let cast, crew: [CastModel]?
}

// MARK: - Cast
struct CastModel: Codable {
    let adult: Bool?
    let gender, id: Int?
    let knownForDepartment, name, originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castID: Int?
    let character, creditID: String?
    let order: Int?
    let department, job: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, department, job
    }
}

