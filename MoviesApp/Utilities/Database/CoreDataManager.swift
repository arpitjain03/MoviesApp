//
//  CoreDataActions.swift
//  MoviesApp
//
//  Created by Arpit Jain on 15/05/21.
//

import Foundation
import  CoreData

enum Entity {
    static let RecentSearches = "RecentSearches"
}

// MARK: - Singleton Class for Handling CoreData
class CoreDataManager: NSObject {
    
    // MARK: - Shared Manager

    static let shared = CoreDataManager()
    
    let containerName = "MoviesApp"
    
    private override init() { }
    
    typealias Completion = (Bool, [NSManagedObject]?, Error?) -> Void
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Public Methods

    /// Function to save record in CoreData
    /// - Parameter completion: <#completion description#>
    public func saveData(completion: (Bool, Error?) -> Void) {
        do {
            try persistentContainer.viewContext.save()
            completion(true, nil)
        } catch {
            print(error)
            completion(false, error)
        }
    }
    
    /// Function to fetch records from CoreData
    /// - Parameters:
    ///   - entity: pass entity name as string
    ///   - updatePredicate: pass predicate as string
    ///   - completion: gets success for completion
    public func fetchData(entity: String, updatePredicate: String?, completion: Completion) {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let sectionSortDescriptor = NSSortDescriptor(key: "_pk", ascending: false)
        let sortDescriptors = [sectionSortDescriptor]
        request.sortDescriptors = sortDescriptors
        
        if updatePredicate != nil {
            request.predicate = NSPredicate(format: updatePredicate!)
        }
        do {
            let result = try persistentContainer.viewContext.fetch(request)
            completion(true, result as? [NSManagedObject], nil)
        } catch {
            completion(false, [], error)
        }
    }
}
