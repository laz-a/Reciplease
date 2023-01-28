//
//  FavoriteList.swift
//  Reciplease
//
//  Created by laz on 04/01/2023.
//

import SwiftUI

struct FavoriteList: View {
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    
    var body: some View {
        Group {
            if recipeViewModel.favorites.isEmpty {
                Text("No favorite")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.reciDark)
                    .foregroundColor(.reciGray)
            } else {
                List(recipeViewModel.favorites) { favorite in
                    ZStack {
                        NavigationLink {
                            FavoriteDetail(favorite: favorite)
                        }
                    label: {
                        EmptyView()
                    }
                    .opacity(0.0)
                    .buttonStyle(PlainButtonStyle())
                        RecipeRow(name: favorite.name, duration: favorite.totalTime, ingredient: favorite.ingredientsShortList)
                            .background {
                                BackgroundImage(height: Constant.rowHeight, data: favorite.image)
                                    .accessibilityHidden(false)
                                    .accessibilityLabel(Text("Recipe illustration"))
                                    .accessibilityValue(Text(favorite.name))
                            }
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.reciDark)
                    .tag(favorite)
                }
                .padding(.top)
                .background(Color.reciDark)
                .listStyle(.plain)
            }
        }
        .navigationTitle("Favorite")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FavoriteList_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteList()
    }
}
