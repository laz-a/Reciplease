//
//  RecipeDetail.swift
//  Reciplease
//
//  Created by laz on 18/12/2022.
//

import SwiftUI

struct RecipeDetail: View {
    var recipe: Recipe
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
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
                            case .failure:
                                Text("Failed fetching image. Make sure to check your data connection and try again.")
                                    .foregroundColor(.red)
                            @unknown default:
                                Text("Unknown error. Please try again.")
                                    .foregroundColor(.red)
                            }
                        }
                        VStack {
                            HStack {
                                Spacer()
                                RecipeDetailCell(recipe: recipe)
                                    .frame(width: 50, height: 50)
                            }
                            
                            Spacer()
                            Text(recipe.label)
                                .font(.title)
                                .background(.red)
                        }
                    }
                    Text("Ingredients")
                        .frame(maxWidth: .infinity)
                        .background(.orange)
                    
                    Text(recipe.ingredientsList)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.yellow)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                }
                .navigationTitle(recipe.label)
                .navigationBarTitleDisplayMode(.inline)
            }
            
            Button {
                print("Save")
            } label: {
                Text("Search for recipes")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(.red)
                    .cornerRadius(5)
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            .disabled(true)
        }
    }
}

struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetail(recipe: ModelData().recipes[0])
    }
}
