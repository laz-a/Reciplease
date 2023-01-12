//
//  Ingredient+CoreDataProperties.swift
//  Reciplease
//
//  Created by laz on 05/01/2023.
//
//

import Foundation
import CoreData


public class Ingredient: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredient> {
        return NSFetchRequest<Ingredient>(entityName: "Ingredient")
    }

    @NSManaged public var id: String
    @NSManaged public var text: String
    @NSManaged public var food: String
    @NSManaged public var foodCategory: String?
    @NSManaged public var quantity: Double
    @NSManaged public var measure: String?
    @NSManaged public var recipe: Favorite
    @NSManaged public var order: Int16

}

extension Ingredient : Identifiable {

}
