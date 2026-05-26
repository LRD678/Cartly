import SwiftUI

struct RecipeCard: View {
    
    @Binding var showPopup: Bool
    @Binding var selectedRecipe : Recipe?
    
    let recipe : Recipe
    
    var body : some View {
        
        Button(action: {
            showPopup = true
            selectedRecipe = recipe
            
        }) {
            
            VStack {
                
                // Set the title
                Text(recipe.title)
                
                // Set the icon
                recipe.icon
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                
                // Set the meal type / calories
                Text(recipe.mealType)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text("\(recipe.calories)")
                    .font(.caption)
                    .foregroundColor(.gray)
                
            }
            
            // Might need to tweak height
            .frame(maxWidth: .infinity, minHeight: 160)
            .background(Color(.systemBackground))
            .cornerRadius(20)
            .shadow(radius: 5)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
    
}
