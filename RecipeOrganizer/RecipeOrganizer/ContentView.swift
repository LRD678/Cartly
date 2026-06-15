import SwiftUI

// Model for recipes not how this should work but gets the job done

struct Recipe: Identifiable {
    let id = UUID()

    var name: String
    var description: String

    var calories: Int
    var prepTime: Int
    var servings: Int

    var ingredients: [(name: String, amount: String)]
    var steps: [String]

    var color: Color
}

struct ContentView: View {
    
    @State private var selectedTab: Int = 1
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("temp")
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)
            
            RecipeOrganizerView()
                .tabItem {
                    Label("Recipes", systemImage: "fork.knife")
                }
                .tag(1)
            
            Text("yeah")
                .tabItem {
                    Label("Meal Plans", systemImage: "folder.fill")
                }
                .tag(2)
            
            Text("Settings Screen")
                .tabItem {
                    Label("List", systemImage: "cart.fill")
                }
                .tag(3)
        }
        
        
    }
}

struct RecipeOrganizerView: View {

    // Recipe filler db
    @State private var recipes: [Recipe] = [
        Recipe(
            name: "Chicken Bowl",
            description: "High protein lunch",
            calories: 650,
            prepTime: 20,
            servings: 2,
            ingredients: [
                ("Chicken Breast", "500g"),
                ("Rice", "2 cups"),
                ("Broccoli", "1 head")
            ],
            steps: [
                "Cook rice",
                "Grill chicken",
                "Combine and serve"
            ],
            color: .orange
        ),

        Recipe(
            name: "Protein Pancakes",
            description: "Quick breakfast",
            calories: 420,
            prepTime: 10,
            servings: 1,
            ingredients: [
                ("Protein Powder", ""),
                ("Eggs", ""),
                ("Oats", "")
            ],
            steps: [
                "Blend ingredients",
                "Cook on skillet",
                "Serve"
            ],
            color: .blue
        ),

        Recipe(
            name: "Pasta",
            description: "Easy dinner",
            calories: 700,
            prepTime: 25,
            servings: 3,
            ingredients: [
                ("Pasta", ""),
                ("Sauce", ""),
                ("Parmesan", "")
            ],
            steps: [
                "Boil pasta",
                "Heat sauce",
                "Mix together"
            ],
            color: .green
        )
    ]

    @State private var selectedRecipe: Recipe?

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var averageCalories: Int {
        guard !recipes.isEmpty else { return 0 }
        return recipes.map(\.calories).reduce(0, +) / recipes.count
    }

    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(spacing: 20) {

                    // Header

                    RoundedRectangle(cornerRadius: 24)
                        .fill(
                            LinearGradient(
                                colors: [.orange, .red],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(height: 160)
                        .overlay(alignment: .leading) {

                            VStack(alignment: .leading, spacing: 8) {

                                Text("Recipe Collection")
                                    .font(.largeTitle.bold())

                                Text("Manage meals and nutrition")
                                    .opacity(0.8)

                                Spacer()

                                Text("\(recipes.count) recipes")
                                    .font(.headline)
                            }
                            .foregroundColor(.white)
                            .padding()
                        }

                    // Stats

                    HStack(spacing: 12) {

                        StatCard(
                            title: "Recipes",
                            value: "\(recipes.count)",
                            color: .blue
                        )

                        StatCard(
                            title: "Avg Calories",
                            value: "\(averageCalories)",
                            color: .green
                        )
                    }

                    // Random filler content

                    VStack(alignment: .leading, spacing: 12) {

                        Text("Recent Activity")
                            .font(.title2.bold())

                        ForEach(0..<4, id: \.self) { index in

                            HStack {

                                Circle()
                                    .fill(.blue)
                                    .frame(width: 10)

                                Text("Edited recipe \(index + 1)")

                                Spacer()

                                Text("Today")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    // Recipes grid

                    VStack(alignment: .leading, spacing: 16) {

                        Text("Recipes")
                            .font(.title.bold())

                        LazyVGrid(
                            columns: columns,
                            spacing: 16
                        ) {

                            ForEach(recipes) { recipe in

                                RecipeCard(recipe: recipe)
                                    .onTapGesture {
                                        selectedRecipe = recipe
                                    }
                            }
                            
                            // add button here
                            Button {

                            } label: {

                                VStack(alignment: .leading, spacing: 10) {

                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(.orange.opacity(0.15))
                                        .frame(height: 100)
                                        .overlay {
                                            Image(systemName: "plus")
                                                .font(.system(size: 36, weight: .bold))
                                                .foregroundStyle(.orange)
                                        }

                                    Text("Add Recipe")
                                        .font(.headline)

                                    Text("Create a recipe")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                        .lineLimit(1)

                                    HStack {
                                        Text(" ")
                                    }
                                    .font(.caption)
                                }
                                .padding()
                                .background(.background)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .shadow(radius: 3)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
            }
            .navigationTitle("Recipe Organizer")
            .sheet(item: $selectedRecipe) { recipe in

                if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {

                    RecipeDetailView(
                        recipe: $recipes[index]
                    )
                }
            }
        }
    }
}

// recipe card in grid

struct RecipeCard: View {

    let recipe: Recipe

    var body: some View {

        VStack(alignment: .leading, spacing: 10) {

            RoundedRectangle(cornerRadius: 16)
                .fill(recipe.color.gradient)
                .frame(height: 100)

            Text(recipe.name)
                .font(.headline)

            Text(recipe.description)
                .font(.caption)
                .foregroundStyle(.secondary)

            HStack {

                Label(
                    "\(recipe.calories)",
                    systemImage: "flame.fill"
                )

                Spacer()

                Text("\(recipe.prepTime)m")
            }
            .font(.caption)
        }
        .padding()
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 3)
    }
}

// just filler stat card

struct StatCard: View {

    let title: String
    let value: String
    let color: Color

    var body: some View {

        VStack(spacing: 6) {

            Text(value)
                .font(.title2.bold())

            Text(title)
                .font(.caption)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(color.opacity(0.15))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

// editor sheet for the recipe

struct RecipeDetailView: View {

    @Binding var recipe: Recipe

    @Environment(\.dismiss) private var dismiss

    var body: some View {

        NavigationStack {

            Form {

                Section("Basic Info") {

                    TextField(
                        "Recipe Name",
                        text: $recipe.name
                    )

                    TextField(
                        "Description",
                        text: $recipe.description
                    )

                    Stepper(
                        "Calories: \(recipe.calories)",
                        value: $recipe.calories,
                        in: 0...5000
                    )

                    Stepper(
                        "Prep Time: \(recipe.prepTime) mins",
                        value: $recipe.prepTime,
                        in: 0...300
                    )

                    Stepper(
                        "Servings: \(recipe.servings)",
                        value: $recipe.servings,
                        in: 1...20
                    )
                }

                Section("Ingredients") {

                    ForEach(recipe.ingredients.indices, id: \.self) { index in

                        HStack {

                            Text(recipe.ingredients[index].name)
                                .foregroundStyle(.primary.opacity(0.85))

                            Spacer()

                            Text(recipe.ingredients[index].amount)
                                .foregroundStyle(.secondary)
                        }
                    }

                    Button {
                        recipe.ingredients.append((name: "", amount: ""))
                    } label: {
                        Label(
                            "Add Ingredient",
                            systemImage: "plus"
                        )
                    }
                }

                Section("Procedure") {

                    ForEach(recipe.steps.indices, id: \.self) { index in

                        TextField(
                            "Step",
                            text: $recipe.steps[index]
                        )
                    }

                    Button {
                        recipe.steps.append("")
                    } label: {
                        Label(
                            "Add Step",
                            systemImage: "plus"
                        )
                    }
                }
            }
            .navigationTitle(recipe.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {

                ToolbarItem(placement: .topBarTrailing) {

                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
