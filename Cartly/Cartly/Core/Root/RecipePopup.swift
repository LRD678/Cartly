import SwiftUI
import PhotosUI

struct RecipePopup: View {
    
    @Binding var showPopup: Bool
    
    @State private var selection = "Dinner"
    let options = ["Breakfast", "Lunch", "Dinner", "Snack", "Other"]
    
    @State private var selectedItem : PhotosPickerItem?
    @State private var selectedImage : Image?
    @State private var recipeName = ""
    @State private var calories = 0
    
    // Pass in recipe and take parameters there to autofill and then if theres no recipe keep all parameters empty
    @Binding var recipe : Recipe?
    
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
                    
                    if let selectedImage {
                        selectedImage
                        // Circle mask when we have a selected image
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
                // Task so we dont slow down run time
                Task {
                    // Wait for image to load
                    if let data = try? await selectedItem?.loadTransferable(type: Data.self),
                       // Set the image
                       let uiImage = UIImage(data: data) {
                        
                        selectedImage = Image(uiImage: uiImage)
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
                showPopup = false
            }
        }
        .padding()
        .onAppear {
            if let recipe {
                        recipeName = recipe.title
                        selection = recipe.mealType
                        calories = recipe.calories
                        selectedImage = recipe.icon
                        }
        }
    }
}

#Preview {
    RecipePopup(showPopup: .constant(true), recipe: .constant(nil))
}
