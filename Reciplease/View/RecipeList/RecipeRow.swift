//
//  RecipeRow.swift
//  Reciplease
//
//  Created by laz on 15/12/2022.
//

import SwiftUI

struct RecipeRow: View {
    var recipe: Recipe
    
    let rowHeight = 120.0
    
    var gradient: LinearGradient {
        .linearGradient(
            Gradient(colors: [.black.opacity(0.9), .black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .top)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                RecipeDetailCell(recipe: recipe)
                    .frame(width: 60)
            }
            Text(recipe.label)
            Text(recipe.ingredients.map { $0.food.capitalized }.joined(separator: ", "))
                .lineLimit(1)
        }
        .padding()
        .background {

            ZStack {
                AsyncImage(url: URL(string: recipe.image)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .progressViewStyle(.circular)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity, maxHeight: rowHeight)
                            .clipped()
                    case .failure:
                        Text("Failed fetching image. Make sure to check your data connection and try again.")
                            .foregroundColor(.red)
                    @unknown default:
                        Text("Unknown error. Please try again.")
                            .foregroundColor(.red)
                    }
                }
                gradient
            }
        }
        .frame(height: rowHeight)
    }
}

struct RecipeRow_Previews: PreviewProvider {
    static var previews: some View {
        RecipeRow(recipe: ModelData().recipes[0])
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
