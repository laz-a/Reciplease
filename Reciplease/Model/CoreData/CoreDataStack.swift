//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by laz on 28/12/2022.
//

import Foundation
import CoreData

final class CoreDataStack {
    
    // MARK: - Properties
    
    private let persistentContainerName = "Reciplease"
    
    // MARK: - Public
    
    var viewContext: NSManagedObjectContext {
        return CoreDataStack.sharedInstance.persistentContainer.viewContext
    }
    
    //MARK: - Singleton
    
    static let sharedInstance = CoreDataStack()
    
    // MARK: - Private
    
    private init() {}
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: persistentContainerName)
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo) for: \(storeDescription.description)")
            }
        }
        // anti doublon
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()
}
