//
//  RecipeRow.swift
//  Reciplease
//
//  Created by laz on 15/12/2022.
//

import SwiftUI

struct RecipeRow: View {
    var recipe: Recipe
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: recipe.image)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .progressViewStyle(.circular)
                case .success(let image):
                    image
//                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    Text("Failed fetching image. Make sure to check your data connection and try again.")
                        .foregroundColor(.red)
                @unknown default:
                    Text("Unknown error. Please try again.")
                        .foregroundColor(.red)
                }
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    RecipeDetailCell(recipe: recipe)
                        .frame(width: 50, height: 50)
                }
                Text(recipe.label)
                    .foregroundColor(.yellow)
                Text(recipe.ingredients.map { $0.food.capitalized }.joined(separator: ", "))
                    .lineLimit(1)
                    .foregroundColor(.yellow)
            }
        }

    }
}

struct RecipeRow_Previews: PreviewProvider {
    static var previews: some View {
        RecipeRow(recipe: ModelData().recipes[0])
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
