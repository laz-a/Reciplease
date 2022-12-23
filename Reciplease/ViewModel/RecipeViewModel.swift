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
    
    @Published var ingredientsList: String = ""
    
    @Published var recipes: [Recipe] = []
    
    @Published private(set) var state = State.idle {
        didSet {
            loaded = state == .loaded
        }
    }
    
    @Published var loaded: Bool = false
    
    func addIngredients(_ ingredients: String) {
        let add = ingredients
            .components(separatedBy: ",")
            .map { $0.trimmingCharacters(in: .whitespaces).capitalized }
            .filter { !self.ingredients.contains($0) && !$0.isEmpty }
        
        self.ingredients += add
        print(self.ingredients)
    }
    
    func clearIngredients() {
        ingredients = []
    }
    
    func searchRecipes() {
        print("searchRecipes")
        state = .loading
        RecipeService.shared.getRecipes(for: ingredients) { response in
            switch response {
            case .success(let recipes):
                self.recipes = recipes
                self.state = .loaded
            case .failure(let error):
                print(error)
                self.state = .failed
            }
        }
    }
    
    func setState(_ state: State) {
        self.state = state
    }
}
