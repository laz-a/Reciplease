//
//  RecipeDetailCell.swift
//  Reciplease
//
//  Created by laz on 18/12/2022.
//

import SwiftUI

struct RecipeDetailCell: View {
    var recipe: Recipe
    
    var body: some View {
        VStack {
            HStack {
                Text("\(recipe.totalTime)k")
                    .frame(width: 25)
                    .font(.caption2)
                Spacer()
                Image(systemName: "hand.thumbsup.fill")
            }
            Spacer()
            HStack {
                Text("\(recipe.totalTime)m")
                    .frame(width: 25)
                    .font(.caption2)
                    
                Spacer()
                Image(systemName: "clock")
            }
        }
        .background(.red)
    }
}

struct RecipeDetailCell_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailCell(recipe: ModelData().recipes[0])
            .previewLayout(.fixed(width: 50, height: 50))
    }
}
