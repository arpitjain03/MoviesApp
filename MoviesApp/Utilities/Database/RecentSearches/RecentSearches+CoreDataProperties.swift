//
//  RecentSearches+CoreDataProperties.swift
//  MoviesApp
//
//  Created by Arpit Jain on 15/05/21.
//
//

import Foundation
import CoreData

extension RecentSearches {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecentSearches> {
        return NSFetchRequest<RecentSearches>(entityName: "RecentSearches")
    }

    @NSManaged public var movieId: String?
    @NSManaged public var originalTitle: String?
    @NSManaged public var posterPath: String?

}
