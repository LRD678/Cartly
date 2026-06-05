// Popup when you click on a recipe card

import SwiftUI
import PhotosUI
import SwiftData

struct RecipePopup: View {
    
    @Environment(\.modelContext) private var context
    
    @Binding var recipe : Recipe?
    
    @Binding var showPopup: Bool
    
    @State private var selection = "Dinner"
    let options = ["Breakfast", "Lunch", "Dinner", "Snack", "Other"]
    
    @State private var selectedItem : PhotosPickerItem?
    @State private var selectedImageData : Data?
    @State private var recipeName = ""
    @State private var calories = 0
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Recipe name
            TextField("Recipe name", text: $recipeName)
                .textFieldStyle(.roundedBorder)
                .padding()
                .font(.title)
            
            // Icon
            PhotosPicker(
                selection: $selectedItem,
                matching: .images
            ) {
                
                VStack {
        
                    if let imageData = selectedImageData,
                           let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150)
                                .clipShape(Circle())
                        } else {
                        // Otherwise just use base photo image
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .padding()
                    }
                }
            }
            // Update the image in the mask to the new selected image whenever the selected image changes
            .onChange(of: selectedItem) {

                Task {

                    if let data = try? await selectedItem?.loadTransferable(type: Data.self) {

                        selectedImageData = data
                    }
                }
            }
            // Meal type & calories in horizontal stack
            HStack(spacing: 20) {
                // Meal Type
                Picker("Select meal type", selection: $selection) {
                    ForEach(options, id: \.self) { option in
                        Text(option)
                    }
                }
                .pickerStyle(.menu)
                
                
                // Calories
                TextField("Enter amount of calories", value: $calories, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                    .padding()
            }
            
            // Tell recipeView to close popup
            Button("Close") {
                if let recipe {

                    // Set the recipes variables to ours when we close so it updates
                    recipe.name = recipeName
                    recipe.mealType = selection
                    recipe.calories = calories
                    recipe.imageData = selectedImageData
                } else {
                    context.insert(Recipe(name: recipeName, mealType: selection, calories: calories, imageData: selectedImageData))
                }
                
                showPopup = false
            }
        }
        .padding()
        .onAppear {

            // Set our own variables to the recipes variables
            if let recipe {
                recipeName = recipe.name
                selection = recipe.mealType
                calories = recipe.calories
                selectedImageData = recipe.imageData
            }
            
        }
    }
}

#Preview {
    RecipePopup(recipe: .constant(nil), showPopup: .constant(false))
}
