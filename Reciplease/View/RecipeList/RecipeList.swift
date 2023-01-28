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
                    .background(Color.reciDark)
                    .foregroundColor(.reciGray)
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
                                    BackgroundImage(height: Constant.rowHeight, src: recipe.image)
                                        .accessibilityHidden(false)
                                        .accessibilityLabel(Text("Recipe illustration"))
                                        .accessibilityValue(Text(recipe.name))
                                }
                        }
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.reciDark)
                        .tag(recipe)
                    }
                    
                    if recipeViewModel.hasNext {
                        ActivityIndicator(isAnimating: .constant(true))
                            .frame(maxWidth: .infinity)
                            .listRowBackground(Color.reciDark)
                            .onAppear {
                                recipeViewModel.loadNextRecipes { success in
                                    print("nextLoaded")
                                }
                            }
                    }
                }
                .padding(.top)
                .listStyle(.plain)
                .environment(\.defaultMinListRowHeight, 10)
                .background(Color.reciDark)
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
