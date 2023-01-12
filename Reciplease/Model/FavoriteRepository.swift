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
    func getFavorites(completion: ([Favorite]) -> Void) {
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        request.sortDescriptors = [
          NSSortDescriptor(keyPath: \Favorite.createdDate, ascending: false)
        ]
        do {
            let recipes = try coreDataStack.viewContext.fetch(request)
            completion(recipes)
        } catch {
            print(error)
            completion([])
        }
    }
    
    func favoriteExist(id: String) -> Bool {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "id == %d" ,id)

        do {
            let count = try coreDataStack.viewContext.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Could not fetch. \(error.localizedDescription)")
            return false
        }
    }
    
    func addFavorite(recipe recipeEdamam: Recipe, image: Data? = nil, completion: () -> Void) {
        let recipe = Favorite(context: coreDataStack.viewContext)
        recipe.id = recipeEdamam.id
        recipe.name = recipeEdamam.name
        recipe.url = recipeEdamam.url
        recipe.source = recipeEdamam.source
        recipe.image = image
        recipe.totalTime = recipeEdamam.totalTime
        
        var order: Int16 = 1
        
        recipe.ingredients = Set(recipeEdamam.ingredients.map {
            let ingredient = Ingredient(context: coreDataStack.viewContext)
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
            try coreDataStack.viewContext.save()
            completion()
        } catch {
            print("We were unable to save \(recipe)")
        }
    }
    
    func deleteFavorite(_ favorite: Favorite, completion: () -> Void) {
        getFavorites { favorites in
            coreDataStack.viewContext.delete(favorite)
            do {
                try coreDataStack.viewContext.save()
                completion()
            } catch {
                print(error)
                completion()
            }
        }
    }
}
