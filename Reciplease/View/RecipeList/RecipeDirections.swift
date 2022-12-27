//
//  RecipeDirections.swift
//  Reciplease
//
//  Created by laz on 24/12/2022.
//

import SwiftUI

struct RecipeDirections: View {
    let recipe: Recipe
    
    var body: some View {
        WebView(url: recipe.url)
//            .toolbar(.hidden, for: .tabBar)
    }
}

struct RecipeDirections_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDirections(recipe: ModelData().recipes[0])
    }
}
