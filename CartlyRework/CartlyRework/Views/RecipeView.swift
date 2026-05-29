//
//  RecipeView.swift
//  CartlyRework
//
//  Created by Student on 2026-05-28.
//

import SwiftUI
import SwiftData

struct RecipeView: View {
    
    @State private var showPopup = false
    @State var selectedRecipe: Recipe?
    
    // Context to edit / add recipes
    @Environment(\.modelContext) private var context
    
    // List of all the recipes
    @Query var recipes: [Recipe]
    
    // Defining grid columns
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        VStack {
            
            Button("debug erase")  {
                for recipe in recipes {
                        context.delete(recipe)
                    }
            }
            
            // Top bar *just for decor
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
            
            Button("Add Test Recipe") {

                let recipe = Recipe(name: "Pasta", mealType: "Dinner", calories: 0, imageName: "fork.knife")

                context.insert(recipe)
            }
            
            // Recipe grid
            ScrollView {
                
                LazyVGrid(columns: columns, spacing: 20) {
                    
                    // Generate cards based off the recipes
                    ForEach(recipes) { recipe in
                        RecipeCard(showPopup: $showPopup, selectedRecipe: $selectedRecipe, recipe: recipe)
                        //showPopup: $showPopup, selectedRecipe: $selectedRecipe, recipe: recipe
                    }
                    
                    // Outside button that will always be there
                    Button(action: {
                        showPopup = true
                    }) {
                        Text("Add recipe")
                            .frame(maxWidth: .infinity, minHeight: 160)
                            .background(Color(.systemBackground))
                            .cornerRadius(20)
                            .shadow(radius: 5)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    
                }
            }
            .padding()
        }
        .sheet(isPresented: $showPopup) {
            RecipePopup(recipe: $selectedRecipe, showPopup: $showPopup)
        }
        
    }
}

#Preview {
    RecipeView()
}
