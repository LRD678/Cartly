//
//  CartlyApp.swift
//  Cartly
//
//  Created by Student on 2026-05-04.
//

import SwiftUI

@main
struct CartlyApp: App {
    
    @StateObject var recipeData = RecipeData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(recipeData)
        }
    }
}
