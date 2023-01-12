//
//  SearchView.swift
//  Reciplease
//
//  Created by laz on 14/12/2022.
//

import SwiftUI

struct SearchView: View {
@State private var isActive = false
    @State private var searchText: String = "Chicken"
    @State private var presentAlertError = false

    @EnvironmentObject var recipeViewModel: RecipeViewModel
//    @ObservedObject private var recipeModel = RecipeViewModel()

    private func addIngredients() {
        recipeViewModel.addIngredients(searchText)
        searchText = ""
    }

    var body: some View {
//        NavigationView {
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
                            recipeViewModel.clearIngredients()
                        }
                        .buttonStyle(GrayButton())
                    }

                    VStack(alignment: .leading, spacing: 5) {
                        ScrollView {
                            Text(recipeViewModel.ingredientsList)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        Spacer()
                        
                        if recipeViewModel.state == .loading {
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
                        
                        NavigationLink(isActive: .constant(recipeViewModel.loaded)) {
                            RecipeList()
                        } label: {
                            Button {
                                if !recipeViewModel.ingredients.isEmpty {
                                    recipeViewModel.searchRecipes()
                                } else {
                                    presentAlertError = true
                                }
                            } label: {
                                Text("Search for recipes")
                            }
                            .alert(isPresented: $presentAlertError) {
                                Alert(
                                    title: Text("Ingredient error"),
                                    message: Text("Add at least one ingredient"))
                            }
                            .buttonStyle(GreenFullButton())
                            .disabled(recipeViewModel.state == .loading)
                        }
                    }
                }
                .padding()
                .navigationTitle("Reciplease")
                .foregroundColor(.white)
            }
            .background(Color.darkBackground)
//        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(RecipeViewModel())
    }
}
