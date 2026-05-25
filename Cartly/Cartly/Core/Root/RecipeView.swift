//
//  RecipeView.swift
//  Cartly
//
//  Created by Student on 2026-05-25.
//

import SwiftUI

struct RecipeView: View {
    
    
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        VStack {
            
            // Top bar
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(radius: 5)
                .frame(maxWidth: .infinity, maxHeight: 60)
                .overlay(
                    HStack {
                        Text("Recipes")
                    }
                        .padding(.horizontal)
                )
                .padding()
            
            // Recipe grid
            // Next week add functionality once I have a database for recipes as well as a popup to add your own which will add a recipe to to the database which will get rendered here
            ScrollView {
                
                LazyVGrid(columns: columns, spacing: 20) {
                    
                    
                    // Temp generated grid
                    ForEach(recipes) { recipe in
                        RecipeCard(recipe: recipe)
                    }
                    
                    // Outside button that will always be there
                    Button(action: {
                        // Show popup
                    }) {
                        Text("Add recipe")
                            .frame(maxWidth: .infinity, minHeight: 160)
                            .background(Color(.systemBackground))
                            .cornerRadius(20)
                            .shadow(radius: 5)
                    }
                    .frame(maxWidth: .infinity) // makes button take full width
                    .padding(.horizontal)
                    
                }
            }
            .padding()
        }
        
        // Create new overlay
        //.overlay {
        //if appState.showPopup {
        
        // Overlay the whole screen and show a dark background
        //Color.black.opacity(0.4)
        //.ignoresSafeArea()
        
        // Display popup
        //RecipePopup(showPopup: showPopup)
    }
    
}

#Preview {
    RecipeView()
}
