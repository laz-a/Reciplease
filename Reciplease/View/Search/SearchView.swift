//
//  SearchView.swift
//  Reciplease
//
//  Created by laz on 14/12/2022.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    
    @State private var isActive = false
    @State private var searchText = "Chicken"
    @State private var presentAlertError = false
    @State private var alertMessage = ""
    
    private func addIngredients() {
        recipeViewModel.addIngredients(searchText)
        searchText = ""
    }

    var body: some View {
            VStack {
                Spacer(minLength: 10)
                VStack {
                    Text("What's in your fridge ?")
                        .font(.title2)
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
                .foregroundColor(.reciDark)
                .background(.white)

                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text("Your ingredients :")
                            .font(.title3)
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
                                    .cornerRadius(10)
                                    .tint(.white)
                            }
                            .scaleEffect(1.4)
                            .padding()
                        }
                        
                        NavigationLink(isActive: .constant(isActive)) {
                            RecipeList()
                        } label: {
                            Button {
                                if !recipeViewModel.ingredients.isEmpty {
                                    recipeViewModel.searchRecipes { success in
                                        if success {
                                            isActive = true
                                        } else {
                                            alertMessage = "API error"
                                            presentAlertError = true
                                        }
                                    }
                                } else {
                                    alertMessage = "Add at least one ingredient"
                                    presentAlertError = true
                                }
                            } label: {
                                Text("Search for recipes")
                            }
                            .alert(isPresented: $presentAlertError) {
                                Alert(
                                    title: Text("Ingredient error"),
                                    message: Text(alertMessage)
                                )
                            }
                            .buttonStyle(GreenFullButton())
                            .disabled(recipeViewModel.state == .loading)
                            .onAppear {
                                print(isActive)
                            }
                        }
                    }
                }
                .padding()
                .navigationTitle("Reciplease")
                .navigationBarTitleDisplayMode(.inline)
                .foregroundColor(.white)
            }
            .background(Color.reciDark)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(RecipeViewModel())
    }
}
