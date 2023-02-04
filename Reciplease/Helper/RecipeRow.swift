//
//  RecipeRow.swift
//  Reciplease
//
//  Created by laz on 15/12/2022.
//

import SwiftUI

struct RecipeRow: View {
    var name: String
    var duration: Int16
    var ingredient: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                RecipeDetailCell(duration: duration)
                    .frame(width: 70)
            }
            Spacer()
            Text(name)
            Text(ingredient)
                .font(.subheadline)
                .lineLimit(1)
        }
        .padding()
        .frame(height: Constant.rowHeight)
    }
}

struct RecipeRow_Previews: PreviewProvider {
    static var previews: some View {
        let recipe = ModelData().edamam.recipes[0]
        RecipeRow(name: recipe.name, duration: recipe.totalTime, ingredient: recipe.ingredientsShortList)
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
