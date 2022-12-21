//
//  RecipeList.swift
//  Reciplease
//
//  Created by laz on 14/12/2022.
//

import SwiftUI

struct RecipeList: View {
    var recipes: [Recipe]
    @State private var path = NavigationPath()
    var body: some View {
            List {
                ForEach(recipes, id: \.uri) { recipe in
                    ZStack {
                        NavigationLink {
                            RecipeDetail(recipe: recipe)
                        }
                        label: {
                            EmptyView()
                        }
                        .opacity(0.0)
                        .buttonStyle(PlainButtonStyle())
                        
                        RecipeRow(recipe: recipe)
                            .frame(height: 90)
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    .tag(recipe)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Reciplease")
            .toolbarBackground(.pink, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeList(recipes: ModelData().recipes)
    }
}
