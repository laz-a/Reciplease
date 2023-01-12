//
//  RecipeList.swift
//  Reciplease
//
//  Created by laz on 14/12/2022.
//

import SwiftUI

struct RecipeList: View {
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    
    var body: some View {
        Group {
            if recipeViewModel.recipes.isEmpty {
                Text("No result")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.darkBackground)
                    .foregroundColor(.grayButton)
            } else {
                List {
                    ForEach(recipeViewModel.recipes) { recipe in
                        ZStack {
                            NavigationLink {
                                RecipeDetail(recipe: recipe)
                            }
                        label: {
                            EmptyView()
                        }
                        .opacity(0.0)
                        .buttonStyle(PlainButtonStyle())
                            
                            RecipeRow(name: recipe.name, duration: recipe.totalTime, ingredient: recipe.ingredientsShortList)
                                .background {
                                    BackgroundImage(src: recipe.image)
                                }
                        }
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.darkBackground)
                        .tag(recipe)
                    }
                    
                    if recipeViewModel.hasNext {
                        ActivityIndicator(isAnimating: .constant(true))
                            .frame(maxWidth: .infinity)
                            .listRowBackground(Color.darkBackground)
                            .onAppear {
                                print("ActivityIndicator")
                                recipeViewModel.loadNextRecipes()
                            }
                    }
                }
                .listStyle(.plain)
                .environment(\.defaultMinListRowHeight, 10)
                .background(Color.darkBackground)
            }
        }.navigationTitle("Reciplease")
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeList()
            .environmentObject(RecipeViewModel())
    }
}
