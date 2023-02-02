//
//  RecipeDetail.swift
//  Reciplease
//
//  Created by laz on 18/12/2022.
//

import SwiftUI

struct RecipeDetail: View {
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    
    var recipe: Recipe
    @State private var recipeImage: Image?
    @State private var showingSheet = false
    @State private var isFavorite = false
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    ZStack {
                        AsyncImage(url: recipe.image) { phase in
                            switch phase {
                            case .empty:
                                ZStack {
                                    Image("default")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                    ProgressView()
                                        .progressViewStyle(.circular)
                                }
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .onAppear {
                                        recipeImage = image
                                    }
                            default:
                                Image("default")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            }
                        }
                        .accessibilityHidden(false)
                        .accessibilityLabel(Text("Recipe illustration"))
                        .accessibilityValue(Text(recipe.name))
                        Constant.gradient
                        VStack {
                            HStack {
                                Spacer()
                                RecipeDetailCell(duration: recipe.totalTime)
                                    .frame(width: 60, height: 60)
                            }
                            .padding()
                            Spacer()
                            Text(recipe.name)
                                .multilineTextAlignment(.center)
                                .font(.title)
                        }.padding(.bottom)
                    }
                    VStack(alignment: .leading) {
                        Text("Ingredients:")
                            .font(.title2)
                        Spacer(minLength: 12)
                        Text(recipe.ingredientsLongList)
                            .accessibilityLabel(Text("Ingredients"))
                            .accessibilityValue(recipe.ingredientsLongList)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                }
                .padding(.top)
                .navigationTitle(recipe.name)
                .navigationBarTitleDisplayMode(.inline)
            }
            
            HStack {
                Button("Get directions") {
                    showingSheet.toggle()
                }
                .buttonStyle(GreenFullButton())
                .fullScreenCover(isPresented: $showingSheet) {
                    RecipeDirections(title: recipe.name, url: recipe.url)
                }
            }
            .padding()
        }
        .background(Color.reciDark)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    FavoriteButton(isSet: $isFavorite, recipe: recipe, imageData: recipeImage?.imageData())
                    .onAppear {
                        isFavorite = recipeViewModel.isFavorite(recipeId: recipe.id)
                    }
                }
            }
        }
    }
}

struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetail(recipe: ModelData().edamam.recipes[0])
            .environmentObject(RecipeViewModel())
    }
}





extension View {
    func imageData() -> Data? {
        let controller = UIHostingController(rootView: self.ignoresSafeArea())
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        let uiImage = renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
        
        return uiImage.jpegData(compressionQuality: 0.8)
    }
}
