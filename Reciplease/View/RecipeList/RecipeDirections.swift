//
//  RecipeDirections.swift
//  Reciplease
//
//  Created by laz on 24/12/2022.
//

import SwiftUI

struct RecipeDirections: View {
    @Environment(\.dismiss) var dismiss
    let title: String
    let url: URL
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer(minLength: 10)
                WebView(url: url)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle(title)
                    .ignoresSafeArea()
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                dismiss()
                            } label: {
                                Label("Close", systemImage: "chevron.down")
                            }
                        }
                    }
            }
            .background(Color.reciDark)
        }
    }
}

struct RecipeDirections_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDirections(title: ModelData().edamam.recipes[0].name, url: ModelData().edamam.recipes[0].url)
    }
}
