// Primary view that controls switching between tabs

import SwiftUI

struct MainView: View {
    
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


#Preview {
    MainView()
}
