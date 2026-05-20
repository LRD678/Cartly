

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            RecipeView()
                .tabItem {
                    Label("Recipes", systemImage: "fork.knife")
                }
            
            Text("Meal Plans")
                .tabItem {
                    Label("Meal Plans", systemImage: "folder.fill")
                }
            
            Text("Settings Screen")
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
}

struct HomeView: View {
    var body: some View {
        VStack {
            // top bar
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(radius: 5)
                .frame(maxWidth: .infinity, maxHeight: 60)
                .overlay(
                    HStack {
                        Text("User Information")

                        Spacer()

                        Image(systemName: "person.fill")
                    }
                    .padding(.horizontal)
                )
                .padding()
            
            Spacer()
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(radius: 5)
                .frame(width: .infinity, height: 400)
                .padding()
        }
    }
}

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
                    ForEach(0..<20) { item in
                        
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(.systemBackground))
                            .shadow(radius: 5)
                            .frame(height: 120)
                            .overlay(
                                Text("Panel \(item + 1)")
                            )
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
