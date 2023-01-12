//
//  FavoriteDetail.swift
//  Reciplease
//
//  Created by laz on 05/01/2023.
//

import SwiftUI

struct FavoriteDetail: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var recipeModel: RecipeViewModel
    var favorite: Favorite
    
    var gradient: LinearGradient {
        .linearGradient(
            Gradient(colors: [.black.opacity(0.5), .black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .center)
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    ZStack {
                        if let imageData = favorite.image {
                            Image(uiImage: UIImage(data: imageData)!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                        VStack {
                            HStack {
                                Spacer()
                                RecipeDetailCell(duration: favorite.totalTime)
                                    .frame(width: 60, height: 60)
                            }
                            .padding()
                            
                            Spacer()
                            Text(favorite.name)
                                .font(.title)
                        }
                        gradient
                    }
                    VStack(alignment: .leading) {
                        Text("Ingredients")
                            .font(.title2)
                        
                        Text(favorite.ingredientsLongList)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                }
                .navigationTitle(favorite.name)
                .navigationBarTitleDisplayMode(.inline)
            }
            
            NavigationLink {
//                WebView(url: favorite.url)
            } label: {
                Text("Get directions")
                    .padding([.top, .bottom], 10)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.greenButton)
                    .cornerRadius(5)
            }
            .padding()
        }
        .background(Color.darkBackground)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    recipeModel.removeFavorite(favorite)
                    dismiss()
                } label: {
                    Label("Toggle favorite", systemImage: "star.fill")
                        .labelStyle(.iconOnly)
                        .foregroundColor(Color.greenButton)
                }
            }
        }
    }
}

//struct FavoriteDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoriteDetail(favorite: <#T##Favorite#>)
//    }
//}
