//
//  RecipeViewModel.swift
//  Reciplease
//
//  Created by laz on 16/12/2022.
//

import Foundation
import Combine

class RecipeViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case failed
        case loaded
    }
    
    var ingredients: [String] = [] {
        didSet {
            ingredientsList = ingredients.map { "- \($0)\n" }.joined()
        }
    }
    
    var next: String?
    
    var hasNext: Bool {
        return next != nil
    }
    
    @Published var ingredientsList: String = ""
    @Published var recipes: [Recipe] = []
    @Published var favorites: [Favorite] = []
    @Published var loaded: Bool = false
    
    @Published private(set) var state = State.idle {
        didSet {
            loaded = state == .loaded
        }
    }
    
    private let recipeRepository = FavoriteRepository()
    
    func addIngredients(_ ingredients: String) {
        let add = ingredients
            .components(separatedBy: ",")
            .reduce([String](), { partialResult, ing in
                let ingredient: String = ing.trimmingCharacters(in: .whitespaces).capitalized
                if !partialResult.contains(ingredient) && !self.ingredients.contains(ingredient) && !ingredient.isEmpty {
                    return partialResult + [ingredient]
                }
                return partialResult
            })
        
        self.ingredients += add
    }
    
    func clearIngredients() {
        ingredients = []
    }
    
    func searchRecipes() {
        state = .loading
        RecipeService.shared.getRecipes(for: ingredients) { response in
            switch response {
            case .success(let edamam):
                self.recipes = edamam.recipes
                self.next = edamam.next
                self.state = .loaded
            case .failure(let error):
                print(error)
                self.state = .failed
            }
        }
    }
    
    func loadNextRecipes() {
        guard let next = next else { return }
//        state = .loading
        RecipeService.shared.getRecipes(url: next) { response in
            switch response {
            case .success(let edamam):
                self.recipes += edamam.recipes
                self.next = edamam.next
//                self.state = .loaded
            case .failure(let error):
                print(error)
//                self.state = .failed
            }
        }
    }
    
    func isFavorite(recipeId: String) -> Bool {
        return recipeRepository.favoriteExist(id: recipeId)
    }
    
    func getFavorites() {
        recipeRepository.getFavorites { recipes in
            favorites = recipes
        }
    }
    
    func addFavorite(_ recipe: Recipe, image: Data? = nil) {
        if let index = recipes.firstIndex(where: { $0 == recipe }) {
            recipes[index].isFavorite = true
        }
        
        recipeRepository.addFavorite(recipe: recipe, image: image) {
            print("addFavorite")
        }
    }
    
    func removeFavorite(_ recipe: Favorite) {
        recipeRepository.deleteFavorite(recipe) {
            print("removeFavorite")
        }
    }
}
