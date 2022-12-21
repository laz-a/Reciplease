//
//  RecipeViewModel.swift
//  Reciplease
//
//  Created by laz on 16/12/2022.
//

import Foundation
import Combine

class RecipeViewModel: ObservableObject {
    var ingredients: [String] = [] {
        didSet {
            ingredientsList = ingredients.map { "- \($0)\n" }.joined()
        }
    }
    
    @Published var ingredientsList: String = ""
    
    @Published var recipes: [Recipe] = []
    
    func addIngredients(_ ingredients: String) {
        let add = ingredients
            .components(separatedBy: ",")
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter { !self.ingredients.contains($0) && !$0.isEmpty }
        
        self.ingredients += add
        print(self.ingredients)
    }
    
    func clearIngredients() {
        ingredients = []
        ingredientsList = "l"
        print(ingredients)
        print(ingredientsList)
    }
    
    func searchRecipes() {
        RecipeService.shared.getRecipes(for: ingredients) { response in
            print(response)
            switch response {
            case .success(let recipes):
                self.recipes = recipes
            case .failure(let error):
                print(error)
            }
        }
    }
}
