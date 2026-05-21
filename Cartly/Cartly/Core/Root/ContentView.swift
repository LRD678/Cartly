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
            
            // Top bar
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
            
            // Bottom box with meal calendar
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(radius: 5)
                .frame(width: .infinity, height: 400)
                .padding()
                .overlay(
                    CalendarView()
                        .padding(40)
                    )

        }
    }
}

struct CalendarView: View {
    @State private var selectedDate = Date()
    
    var body: some View {
        DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
        
            // Full calendar view switch to week view per row
            .datePickerStyle(.graphical)
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
                    ForEach(0..<50) { item in
                        
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(.systemBackground))
                            .shadow(radius: 5)
                            .frame(height: 160)
                            .overlay(
                                VStack {
                                    Text("Recipe Placeholder")
                                    Image(systemName: "fork.knife.circle")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    Text("Dinner, Lunch")
                                }
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
