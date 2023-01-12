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
                    .background(Color.darkBackground)
                    .foregroundColor(.grayButton)
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
                                BackgroundImage(data: favorite.image)
                            }
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.darkBackground)
                    .tag(favorite)
                }
                .background(Color.darkBackground)
                .listStyle(.plain)
                .background(Color.darkBackground)
            }
        }.navigationTitle("Reciplease")
    }
}

struct FavoriteList_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteList()
    }
}
