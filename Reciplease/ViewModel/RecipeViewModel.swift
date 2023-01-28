//
//  RecipeViewModel.swift
//  Reciplease
//
//  Created by laz on 16/12/2022.
//

import Foundation
import Combine
import Alamofire

class RecipeViewModel: ObservableObject {
    private var recipeService: RecipeService
    
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
    
    init(session: Session = Session.default) {
        recipeService = RecipeService(session: session)
    }
    
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
    
    func searchRecipes(completionHandler: @escaping(Bool) -> Void) {
        if ingredients.isEmpty {
            completionHandler(false)
        } else {
            state = .loading
            recipeService.getRecipes(for: ingredients) { response in
                switch response {
                case .success(let edamam):
                    self.recipes = edamam.recipes
                    self.next = edamam.next
                    self.state = .loaded
                    completionHandler(true)
                case .failure(let error):
                    print(error)
                    self.state = .failed
                    completionHandler(false)
                }
            }
        }
    }
    
    func loadNextRecipes(completionHandler: @escaping(Bool) -> Void) {
        guard let next = next else {
            completionHandler(false)
            return
        }
//        state = .loading
        recipeService.getRecipes(url: next) { response in
            switch response {
            case .success(let edamam):
                self.recipes += edamam.recipes
                self.next = edamam.next
                completionHandler(true)
//                self.state = .loaded
            case .failure(let error):
                completionHandler(false)
                print(error)
//                self.state = .failed
            }
        }
    }
    
    func isFavorite(recipeId: String) -> Bool {
        return recipeRepository.favoriteExist(id: recipeId)
    }
    
    func getFavorites(completionHandler: @escaping(Bool) -> Void) {
        recipeRepository.getFavorites { recipes in
            favorites = recipes
            completionHandler(true)
        }
    }
    
    func addFavorite(_ recipe: Recipe, image: Data? = nil) {
        recipeRepository.addFavorite(recipe: recipe, image: image) {
            print("addFavorite")
        }
    }
    
    func removeFavorite(_ recipe: Favorite) {
        recipeRepository.deleteFavorite(recipe) {
            print("removeFavorite")
        }
    }
    
    func removeFavorite(_ recipe: Recipe) {
        recipeRepository.getFavorite(id: recipe.id) { favorite in
            if let favorite = favorite {
                removeFavorite(favorite)
            }
        }
    }
}
