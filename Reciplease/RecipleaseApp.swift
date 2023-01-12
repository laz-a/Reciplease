//
//  RecipleaseApp.swift
//  Reciplease
//
//  Created by laz on 14/12/2022.
//

import SwiftUI

@main
struct RecipleaseApp: App {
    @StateObject private var recipeViewModel = RecipeViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(recipeViewModel)
        }
    }
}
