import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab: Int = 3
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("temp")
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)
            
            Text("temp")
                .tabItem {
                    Label("Recipes", systemImage: "fork.knife")
                }
                .tag(1)
            
            Text("bleh")
                .tabItem {
                    Label("Meal Plans", systemImage: "folder.fill")
                }
                .tag(2)
            
            ListView()
                .tabItem {
                    Label("List", systemImage: "cart.fill")
                }
                .tag(3)
        }
        
        
    }
}
    
struct ListView : View {
        
        // Base selected
        @State private var selectedMealPlan = "June 1 - June 7"
        
        // Show the sheet
        @State private var showShoppingList = false
        
        @State private var meals = 12
        @State private var ingredients = 38
        
        // Just a sample meal plan list
        let mealPlans = [
            "June 1 - June 7",
            "June 8 - June 14",
            "June 15 - June 21",
            "June 22 - July 28"
        ]
        
    var body: some View {
        NavigationStack {
            ScrollView {
                
                VStack(spacing: 25) {
                    
                    // Meal plan selection
                    
                    VStack(alignment: .leading, spacing: 15) {
                        
                        Text("Select Meal Plan")
                            .font(.headline)
                        
                        Picker("Meal Plan", selection: $selectedMealPlan) {
                            ForEach(mealPlans, id: \.self) { plan in
                                Text(plan)
                            }
                        }
                        .onChange(of: selectedMealPlan) {
                            
                            // SO lazy im making it generate random numbers :)
                            meals = Int.random(in: 0...50)
                            ingredients = 12 // Match the amt that will get generated
                        }
                        .pickerStyle(.menu)
                        
                        Divider()
                        
                        // Display chosen meal plan week
                        HStack {
                            
                            Image(systemName: "calendar")
                            
                            Text(selectedMealPlan)
                            
                            Spacer()
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    // Fancy stats cards that 100% work
                    
                    HStack(spacing: 15) {
                        
                        StatCard(
                            icon: "fork.knife",
                            title: String(meals),
                            subtitle: "Meals"
                        )
                        
                        StatCard(
                            icon: "basket",
                            title: String(ingredients),
                            subtitle: "Ingredients"
                        )
                    }
                    
                    // Meal suggestions
                    
                    VStack(alignment: .leading, spacing: 12) {
                        
                        Label("Meal Plan Suggestions", systemImage: "lightbulb.max")
                        // Change sparkles?
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                
                                // Hard code all these in maybe make them generate off list in future
                                
                                SuggestionCard(
                                    title: "Chicken Meal Plan",
                                    subtitle: "High-protein weekly plan",
                                    icon: "fork.knife",
                                    color: Color.orange.opacity(0.2)
                                )
                                
                                SuggestionCard(
                                    title: "Budget Grocery List",
                                    subtitle: "Cheap & efficient essentials",
                                    icon: "dollarsign.circle",
                                    color: Color.green.opacity(0.2)
                                )
                                
                                SuggestionCard(
                                    title: "Vegetarian Week",
                                    subtitle: "Balanced plant-based meals",
                                    icon: "leaf",
                                    color: Color.green.opacity(0.25)
                                )
                                
                                SuggestionCard(
                                    title: "Quick 5-Day Meals",
                                    subtitle: "Fast prep, minimal ingredients",
                                    icon: "bolt",
                                    color: Color.blue.opacity(0.2)
                                )
                            }
                            .padding(.horizontal, 2)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    
                    // Generate shopping list button
                    
                    Button {
                        
                        withAnimation(.spring()) {
                            showShoppingList = true
                        }
                        
                    } label: {
                        
                        HStack {
                            
                            Image(systemName: "cart.badge.plus")
                            
                            Text("Generate Shopping List")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Spacer()
                    
                }
                .padding()
                .navigationTitle("Shopping List")
                .navigationBarTitleDisplayMode(.large)
                .sheet(isPresented: $showShoppingList) {
                    
                    
                    ShoppingListSheet(
                        selectedPlan: selectedMealPlan
                    )
                }
            }
        }
        }
    }

struct SuggestionCard: View {
    var title: String
    var subtitle: String
    var icon: String
    var color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {

            // Corner icon
            Image(systemName: icon)
                .font(.system(size: 22, weight: .semibold))
                .frame(width: 52, height: 52)
                .background(Color.white.opacity(0.85))
                .clipShape(RoundedRectangle(cornerRadius: 14))

            Spacer()

            Text(title)
                .font(.headline)

            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(width: 220, height: 180)
        .background(color)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 3)
    }
}

struct ShoppingListSheet: View {
    @Environment(\.dismiss) private var dismiss

    // Just to make it look nice nothing to do with functionality
    @State private var copied = false

    let selectedPlan: String

    // Just a filler bleh list of ingredients
    let ingredients = [
        ("Chicken Breast", "2 lbs"),
        ("Rice", "1 kg"),
        ("Broccoli", "3 heads"),
        ("Milk", "2 L"),
        ("Eggs", "12"),
        ("Ground Beef", "1 lb"),
        ("Pasta", "500 g"),
        ("Tomato Sauce", "2 jars"),
        ("Bell Peppers", "4"),
        ("Cheddar Cheese", "300 g"),
        ("Greek Yogurt", "1 tub"),
        ("Bananas", "6")
    ]

    var body: some View {

        NavigationStack {

            VStack(spacing: 20) {

                VStack(spacing: 10) {

                    // Header
                    
                    Image(systemName: "cart.badge.plus")
                        .font(.system(size: 55))
                        .foregroundStyle(.blue)

                    Text("Shopping List")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text(selectedPlan)
                        .foregroundStyle(.secondary)
                }

                ScrollView {

                    LazyVStack(spacing: 12) {

                        // Generate panel for each ingredient
                        ForEach(ingredients, id: \.0) { item in

                            HStack {

                                Text(item.0)

                                Spacer()

                                Text(item.1)
                                    .foregroundStyle(.secondary)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .clipShape(
                                RoundedRectangle(cornerRadius: 15)
                            )
                        }
                    }
                    .padding(.horizontal)
                }

                Button {


                    copied = true

                    // Cool little animation i dont know why i have time to do this
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        copied = false
                    }

                } label: {

                    Label(
                        copied ? "Copied!" : "Copy to Clipboard",
                        systemImage: copied ? "checkmark.circle.fill" : "doc.on.doc"
                    )
                    .frame(maxWidth: .infinity)
                    .padding()
                }
                .buttonStyle(.borderedProminent)
                .padding(.horizontal)

                // Close sheet button
                Button("Close") {
                    dismiss()
                }
                .padding(.bottom)
            }
            .padding(.top)
        }
    }
}

// Just for the meal suggestion scroll
struct StatCard: View {

    let icon: String
    let title: String
    let subtitle: String

    var body: some View {

        VStack(spacing: 8) {
            
            // Icon
            Image(systemName: icon)
                .font(.title2)

            // Title of whatever panel is recomending
            Text(title)
                .font(.title2)
                .fontWeight(.bold)

            // Subtitle *CHANGE FONT LATER FOR VISIBILITY
            Text(subtitle)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    ContentView()
}
