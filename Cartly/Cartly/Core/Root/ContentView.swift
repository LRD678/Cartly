import SwiftUI

// Global variables
//@EnvironmentObject var appState: AppState

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


// MIGRATE CALENDAR AND PROFILE INTO SEPARATE SCRIPTS !!!


struct CalendarView: View {
    @State private var selectedDate = Date()
    
    var body: some View {
        DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
        
            // Full calendar view switch to week view per row
            .datePickerStyle(.graphical)
    }
}


#Preview {
    ContentView()
}
