//
//  SearchView.swift
//  Reciplease
//
//  Created by laz on 14/12/2022.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText: String = ""
    
    @ObservedObject private var recipeModel = RecipeViewModel()
    
    private func addIngredients() {
        recipeModel.addIngredients(searchText)
        searchText = ""
    }
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack {
                    Spacer()
                    VStack {
                        Text("What's in your fridge ?")
                        HStack {
                            VStack {
                                TextField("Lemon, Cheese, Sausages...", text: $searchText)
                                    .onSubmit {
                                        addIngredients()
                                    }
                                    .submitLabel(.done)
                                Divider()
                            }
                            Button("Add") {
                                addIngredients()
                            }
                            .buttonStyle(GreenButton())
                        }
                    }
                    .padding()
                    .foregroundColor(.darkBackground)
                    .background(.white)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Text("Your ingredients :")
                            Spacer()
                            Button("Clear") {
                                recipeModel.clearIngredients()
                            }
                            .buttonStyle(GrayButton())
                        }
                        
                        Text(recipeModel.ingredientsList)
                        
                        Spacer()
                        
                        if recipeModel.state == .loading {
                            HStack(alignment: .center) {
                                ProgressView()
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(Color.darkBackground)
                                    .cornerRadius(10)
                                    .tint(.white)
                            }
                            .scaleEffect(2)
                            .padding()
                        }
                        
                        Button {
                            recipeModel.searchRecipes()
                        } label: {
                            Text("Search for recipes")
                        }
                        .buttonStyle(GreenFullButton())
                        .disabled(recipeModel.state == .loading)
                    }
                    .padding()
                    .navigationTitle("Reciplease")
                    .foregroundColor(.white)
                }.navigationDestination(isPresented: $recipeModel.loaded) {
                    RecipeList(recipes: recipeModel.recipes)
                }
                .background(Color.darkBackground)
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
