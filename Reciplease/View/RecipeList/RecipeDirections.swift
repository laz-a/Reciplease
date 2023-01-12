//
//  RecipeDirections.swift
//  Reciplease
//
//  Created by laz on 24/12/2022.
//

import SwiftUI

struct RecipeDirections: View {
    let url: URL
    
    var body: some View {
        WebView(url: url)
    }
}

struct RecipeDirections_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDirections(url: ModelData().recipes[0].url)
    }
}
