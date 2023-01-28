//
//  Favorite+CoreDataClass.swift
//  Reciplease
//
//  Created by laz on 05/01/2023.
//
//

import Foundation
import CoreData


public class Favorite: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var name: String
    @NSManaged public var image: Data?
    @NSManaged public var source: String
    @NSManaged public var url: URL
    @NSManaged public var id: String
    @NSManaged public var totalTime: Int16
    @NSManaged public var ingredients: Set<Ingredient>
    @NSManaged public var createdDate: Date
    
    // Inline ingredients list
    var ingredientsShortList: String {
        ingredients.sorted { $0.order < $1.order }.map { $0.food.capitalized }.joined(separator: ", ")
    }
    
    // Complete ingredients list
    var ingredientsLongList: String {
        ingredients.sorted { $0.order < $1.order }.map { $0.text }.joined(separator: "\n")
    }
    
    // Set default 'createdDate'
    override public func awakeFromInsert() {
        setPrimitiveValue(Date(), forKey: "createdDate")
    }
}

extension Favorite : Identifiable { }
