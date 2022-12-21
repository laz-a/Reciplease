//
//  ContentView.swift
//  Reciplease
//
//  Created by laz on 14/12/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .search
    
    enum Tab {
        case search
        case favorite
    }
    
    var body: some View {
        TabView(selection: $selection) {
            SearchView()
                .tabItem {
                    Text("Search")
                }
            NavigationView {
                RecipeList(recipes: ModelData().recipes)
            }
            .tabItem {
                Text("Favorite")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
