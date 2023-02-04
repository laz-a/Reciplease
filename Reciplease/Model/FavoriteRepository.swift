//
//  FavoriteRepository.swift
//  Reciplease
//
//  Created by laz on 28/12/2022.
//

import Foundation
import CoreData

final class FavoriteRepository {

    // MARK: - Properties
    private let coreDataStack: CoreDataStack

    // MARK: - Init
    init(coreDataStack: CoreDataStack = CoreDataStack.sharedInstance) {
      self.coreDataStack = coreDataStack
    }

    // MARK: - Repository
    
    // Get all favorites
    func getFavorites(completion: @escaping([Favorite]) -> Void) {
        DispatchQueue.main.async {
            let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
            fetchRequest.sortDescriptors = [
                NSSortDescriptor(keyPath: \Favorite.createdDate, ascending: false)
            ]
            do {
                let recipes = try self.coreDataStack.viewContext.fetch(fetchRequest)
                completion(recipes)
            } catch {
                print(error)
                completion([])
            }
        }
    }
    
    // Get favorite by id
    func getFavorite(id: String, completion: @escaping(Favorite?) -> Void) {
        DispatchQueue.main.async {
            let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
            fetchRequest.fetchLimit =  1
            fetchRequest.predicate = NSPredicate(format: "id == %@" ,id)
            
            do {
                let favorite = try self.coreDataStack.viewContext.fetch(fetchRequest)
                completion(favorite[0])
            } catch {
                print(error)
                completion(nil)
            }
        }
    }
    
    // Check if favorite exist
    func favoriteExist(id: String) -> Bool {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "id == %@" ,id)
        
        do {
            let count = try coreDataStack.viewContext.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Could not fetch. \(error.localizedDescription)")
            return false
        }
    }
    
    // Add favorite
    func addFavorite(recipe: Recipe, image: Data? = nil, completion: @escaping() -> Void) {
        DispatchQueue.main.async {
            let favorite = Favorite(context: self.coreDataStack.viewContext)
            favorite.id = recipe.id
            favorite.name = recipe.name
            favorite.url = recipe.url
            favorite.source = recipe.source
            favorite.image = image
            favorite.totalTime = recipe.totalTime
            
            var order: Int16 = 1
            
            favorite.ingredients = Set(recipe.ingredients.map {
                let ingredient = Ingredient(context: self.coreDataStack.viewContext)
                ingredient.id = $0.id
                ingredient.text = $0.text
                ingredient.food = $0.food
                ingredient.foodCategory = $0.foodCategory
                ingredient.quantity = $0.quantity
                ingredient.measure = $0.measure
                ingredient.order = order
                order += 1
                return ingredient
            })
            
            do {
                try self.coreDataStack.viewContext.save()
                completion()
            } catch {
                print("We were unable to save \(favorite)")
            }
        }
    }
    
    // Remove favorite
    func deleteFavorite(_ favorite: Favorite, completion: @escaping() -> Void) {
        DispatchQueue.main.async {
            self.coreDataStack.viewContext.delete(favorite)
            do {
                try self.coreDataStack.viewContext.save()
                completion()
            } catch {
                print(error)
                completion()
            }
        }
    }
}
