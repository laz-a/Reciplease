//
//  FavoriteDetail.swift
//  Reciplease
//
//  Created by laz on 05/01/2023.
//

import SwiftUI

struct FavoriteDetail: View {
    @EnvironmentObject var recipeModel: RecipeViewModel
    @Environment(\.openURL) var openURL
    @Environment(\.dismiss) var dismiss
    
    @State private var showingSheet = false
    
    var favorite: Favorite
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    ZStack {
                        BackgroundImage(height: .infinity, data: favorite.image)
                            .accessibilityHidden(false)
                            .accessibilityLabel(Text("Recipe illustration"))
                            .accessibilityValue(Text(favorite.name))
                        Constant.gradient
                        VStack {
                            HStack {
                                Spacer()
                                RecipeDetailCell(duration: favorite.totalTime)
                                    .frame(width: 60, height: 60)
                            }
                            .padding()
                            
                            Spacer()
                            Text(favorite.name)
                                .multilineTextAlignment(.center)
                                .font(.title)
                        }
                    }
                    VStack(alignment: .leading) {
                        Text("Ingredients:")
                            .font(.title2)
                        Spacer(minLength: 12)
                        Text(favorite.ingredientsLongList)
                            .accessibilityLabel(Text("Ingredients"))
                            .accessibilityValue(favorite.ingredientsLongList)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                }
                .padding(.top)
                .navigationTitle(favorite.name)
                .navigationBarTitleDisplayMode(.inline)
            }
            
            HStack {
                Button("Get directions") {
                    openURL(favorite.url)
                }
                .buttonStyle(GreenFullButton())
            }
            .padding()
        }
        .background(Color.reciDark)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    recipeModel.removeFavorite(favorite)
                    dismiss()
                } label: {
                    Label("Toggle favorite", systemImage: "star.fill")
                        .labelStyle(.iconOnly)
                        .foregroundColor(Color.reciGreen)
                }
            }
        }
    }
}
