//
//  FavoriteDetail.swift
//  Reciplease
//
//  Created by laz on 05/01/2023.
//

import SwiftUI

struct FavoriteDetail: View {
    @EnvironmentObject var recipeModel: RecipeViewModel
    @Environment(\.dismiss) var dismiss
    @State private var showingSheet = false
    
    var favorite: Favorite
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    ZStack {
                        BackgroundImage(height: .infinity, data: favorite.image)
                        Constant.gradient
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
                    }
                    VStack(alignment: .leading) {
                        Text("Ingredients")
                            .font(.title2)
                        
                        Text(favorite.ingredientsLongList)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                }
                .padding(.top)
                .navigationTitle(favorite.name)
                .navigationBarTitleDisplayMode(.inline)
            }
            
            HStack {
                Button("Get directions") {
                    showingSheet.toggle()
                }
                .buttonStyle(GreenFullButton())
                .fullScreenCover(isPresented: $showingSheet) {
                    RecipeDirections(title: favorite.name, url: favorite.url)
                }
            }
            .padding()
        }
        .background(Color.reciDark)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    recipeModel.removeFavorite(favorite)
                    dismiss()
                } label: {
                    Label("Toggle favorite", systemImage: "star.fill")
                        .labelStyle(.iconOnly)
                        .foregroundColor(Color.reciGreen)
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
