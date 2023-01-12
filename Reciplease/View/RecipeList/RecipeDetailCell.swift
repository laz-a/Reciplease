//
//  RecipeDetailCell.swift
//  Reciplease
//
//  Created by laz on 18/12/2022.
//

import SwiftUI

struct RecipeDetailCell: View {
    var duration: Int16
    
    var body: some View {
        VStack {
            HStack {
                Text(duration.toTime)
                    .font(.caption2)
                Spacer()
                Image(systemName: "clock")
                    .scaleEffect(0.8)
            }
        }
        .padding(4)
        .background(Color.darkBackground)
        .foregroundColor(.white)
        .cornerRadius(3)
        .overlay {
            RoundedRectangle(cornerRadius: 3)
                .stroke(.white, lineWidth: 1)
        }
    }
}

struct RecipeDetailCell_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailCell(duration: ModelData().recipes[0].totalTime)
            .previewLayout(.fixed(width: 50, height: 50))
    }
}
