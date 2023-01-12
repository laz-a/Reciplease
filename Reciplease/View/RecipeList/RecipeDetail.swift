//
//  RecipeDetail.swift
//  Reciplease
//
//  Created by laz on 18/12/2022.
//

import SwiftUI

struct RecipeDetail: View {
    @EnvironmentObject var recipeModel: RecipeViewModel
    @State var recipe: Recipe
    @State private var recipeImage: Image?
    
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
                        AsyncImage(url: recipe.image) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .progressViewStyle(.circular)
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .onAppear {
                                        print("onAppear :: recipeImage")
                                        recipeImage = image
                                    }
                            case .failure:
                                Text("Failed fetching image. Make sure to check your data connection and try again.")
                                    .foregroundColor(.red)
                            @unknown default:
                                Text("Unknown error. Please try again.")
                                    .foregroundColor(.red)
                            }
                        }
                        VStack {
                            HStack {
                                Spacer()
                                RecipeDetailCell(duration: recipe.totalTime)
                                    .frame(width: 60, height: 60)
                            }
                            .padding()
                            
                            Spacer()
                            Text(recipe.name)
                                .font(.title)
                        }
                        gradient
                    }
                    VStack(alignment: .leading) {
                        Text("Ingredients")
                            .font(.title2)
                        
                        Text(recipe.ingredientsLongList)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                }
                .navigationTitle(recipe.name)
                .navigationBarTitleDisplayMode(.inline)
            }
            
            NavigationLink {
                WebView(url: recipe.url)
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
                    if !recipe.isFavorite {
                        recipeModel.addFavorite(recipe, image: recipeImage?.imageData())
                    }
                } label: {
                    Label("Toggle favorite", systemImage: recipe.isFavorite ? "star.fill" : "star")
                        .labelStyle(.iconOnly)
                        .foregroundColor(Color.greenButton)
                }
                .onAppear {
                    print("~~~~~~~~~~isFavorite~~~~~~~~~~")
                    print(recipe.isFavorite)
                    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
                }
            }
        }
    }
}

struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetail(recipe: ModelData().recipes[0])
            .environmentObject(RecipeViewModel())
    }
}





extension View {
    func imageData() -> Data? {
        let controller = UIHostingController(rootView: self.ignoresSafeArea())
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .yellow

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        let uiImage = renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
        
        
        let imageData = uiImage.jpegData(compressionQuality: 0.8)
        
        return imageData
    }
}
