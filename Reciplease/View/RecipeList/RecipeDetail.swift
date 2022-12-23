//
//  RecipeDetail.swift
//  Reciplease
//
//  Created by laz on 18/12/2022.
//

import SwiftUI

struct RecipeDetail: View {
    var recipe: Recipe
    
    var gradient: LinearGradient {
        .linearGradient(
            Gradient(colors: [.black.opacity(0.5), .black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .center)
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
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
                                    .frame(width: 60, height: 60)
                            }
                            .padding()
                            
                            Spacer()
                            Text(recipe.label)
                                .font(.title)
                        }
                        gradient
                    }
                    VStack(alignment: .leading) {
                        Text("Ingredients")
                            .font(.title2)
                        
                        Text(recipe.ingredientsList)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                }
                .navigationTitle(recipe.label)
                .navigationBarTitleDisplayMode(.inline)
            }
            
            Button {
                print("Save")
            } label: {
                Text("Get directions")
            }
            .buttonStyle(GreenFullButton())
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            .disabled(true)
        }
        .background(Color.darkBackground)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                FavoriteButton(isSet: .constant(true))
            }
        }
    }
}

struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetail(recipe: ModelData().recipes[0])
    }
}
