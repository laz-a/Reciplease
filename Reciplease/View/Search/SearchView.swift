//
//  SearchView.swift
//  Reciplease
//
//  Created by laz on 14/12/2022.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText: String = ""
    
    private var recipeModel = RecipeViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                VStack {
                    Text("What's in your fridge ?")
                    HStack {
                        VStack {
                            TextField("Lemon, Cheese, Sausages...", text: $searchText)
                            Divider()
                        }
                        Button {
                            print("la")
                            print(searchText)
                            recipeModel.addIngredients(searchText)
                            searchText = ""
                        } label: {
                            Text("Add")
                                .padding([.top, .bottom], 10)
                                .frame(width: 60)
                                .foregroundColor(.white)
                                .background(Color.greenButton)
                                .cornerRadius(5)
                        }
                    }
                }
                .padding()
                .background(.white)

                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text("Your ingredients :")
                        Spacer()
                        Button {
                            print("la 2")
                            recipeModel.clearIngredients()
                        } label: {
                            Text("Clear")
                                .padding([.top, .bottom], 10)
                                .frame(width: 60)
                                .foregroundColor(.white)
                                .background(Color.grayButton)
                                .cornerRadius(5)
                        }
                    }
                    Text(recipeModel.ingredientsList)

                    Spacer()

                    NavigationLink(destination: RecipeList(recipes: recipeModel.recipes)) {
                        Button {
                            print("Save")
                            recipeModel.searchRecipes()
                        } label: {
                            Text("Search for recipes")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.greenButton)
                                .cornerRadius(5)
                        }
                        .disabled(true)
                    }
                }
                .padding()
                .navigationTitle("Reciplease")
                
//                .toolbarBackground(.pink, for: .navigationBar)
//                .toolbarBackground(.visible, for: .navigationBar)
                
//                .background(.orange)
            }
            .background(Color.darkBackground)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
