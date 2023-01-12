//
//  ContentView.swift
//  Reciplease
//
//  Created by laz on 14/12/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    @State private var selection: Tab = .search
    
    enum Tab {
        case search
        case favorite
    }
    
    var body: some View {
        TabView(selection: $selection) {
            Group {
                NavigationView {
                    SearchView()
                }
                .tabItem {
                    Text("Search")
                        .font(Font.custom("Cera-Regular", size: 36))
                }
                .tag(Tab.search)
                
                NavigationView {
                    FavoriteList()
                        .onAppear {
                            print("FavoriteList ~~~~~~ onAppear")
                            recipeViewModel.getFavorites()
                        }
                }
                .tabItem {
                    Text("Favorite").font(.system(size: 36))
                }
                .tag(Tab.favorite)
            }
            .tabbarAppearance(backgroundColor: .darkBackground)
        }
        .navigationAppearance(backgroundColor: .darkBackground, foregroundColor: .white)
        .tint(.white)
        .foregroundColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(RecipeViewModel())
    }
}
