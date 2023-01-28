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
                }
                .tag(Tab.search)
                
                NavigationView {
                    FavoriteList()
                        .onAppear {
                            recipeViewModel.getFavorites { success in
                                print("success :: \(success)")
                            }
                        }
                }
                .tabItem {
                    Text("Favorite")
                }
                .tag(Tab.favorite)
            }
            .tabbarAppearance(backgroundColor: .reciDark)
        }
        .navigationAppearance(backgroundColor: .reciDark, foregroundColor: .white)
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
