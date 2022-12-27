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
    
//    init() {
//        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -40)
//     UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.init(name: "system", size: 55)! ], for: .normal)
//    }
    
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
                    RecipeList(recipes: ModelData().recipes)
                }
                .tabItem {
                    Text("Favorite").font(.system(size: 36))
                }
                .tag(Tab.favorite)
            }
            .tabbarAppearance(backgroundColor: .darkBackground)
//            .toolbar(.visible, for: .tabBar)
//            .toolbarBackground(Color.darkBackground, for: .tabBar)
        }
        .navigationAppearance(backgroundColor: .darkBackground, foregroundColor: .white)
        .tint(.white)
        .foregroundColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
