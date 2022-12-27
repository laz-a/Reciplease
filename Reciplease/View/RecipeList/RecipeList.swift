//
//  RecipeList.swift
//  Reciplease
//
//  Created by laz on 14/12/2022.
//

import SwiftUI

struct RecipeList: View {
    var recipes: [Recipe]
    
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
                }
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
                .tag(recipe)
            }
            .background(Color.darkBackground)
        }
        .listStyle(.plain)
        .background(Color.darkBackground)
        .navigationTitle("Reciplease")
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeList(recipes: ModelData().recipes)
    }
}
