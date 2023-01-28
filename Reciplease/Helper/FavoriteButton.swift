//
//  FavoriteButton.swift
//  Reciplease
//
//  Created by laz on 20/01/2023.
//

import SwiftUI

struct FavoriteButton: View {
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    @Binding var isSet: Bool
    
    var recipe: Recipe
    var imageData: Data?
    
    var body: some View {
        Button {
            isSet.toggle()
            if !recipeViewModel.isFavorite(recipeId: recipe.id) {
                recipeViewModel.addFavorite(recipe, image: imageData)
            } else {
                recipeViewModel.removeFavorite(recipe)
            }
        } label: {
            Label("Toggle favorite", systemImage: isSet ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundColor(isSet ? Color.reciGreen : .gray)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isSet: .constant(true), recipe: ModelData().edamam.recipes[0])
            .environmentObject(RecipeViewModel())
    }
}
