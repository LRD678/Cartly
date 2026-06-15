import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State private var selectedTab: Int = 2
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("temp")
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)
            
            Text("sh")
                .tabItem {
                    Label("Recipes", systemImage: "fork.knife")
                }
                .tag(1)
            
            MealView()
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

struct MealView: View {

    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(spacing: 20) {

                    RoundedRectangle(cornerRadius: 24)
                        .fill(
                            LinearGradient(
                                colors: [.green, .mint],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(height: 170)
                        .overlay(alignment: .leading) {

                            VStack(alignment: .leading, spacing: 8) {

                                Text("Meal Planner")
                                    .font(.largeTitle.bold())

                                Text("Organize your meals for the week")
                                    .opacity(0.9)

                                Spacer()

                                Text("18 Meals Planned")
                                    .font(.headline)
                            }
                            .foregroundStyle(.white)
                            .padding()
                        }

                    AlbumView()

                    VStack(alignment: .leading, spacing: 12) {

                        Text("Upcoming Meals")
                            .font(.title2.bold())

                        UpcomingMealRow(
                            title: "Monday Dinner",
                            meal: "Chicken Wrap"
                        )

                        UpcomingMealRow(
                            title: "Tuesday Lunch",
                            meal: "Rice Bowl"
                        )

                        UpcomingMealRow(
                            title: "Wednesday Breakfast",
                            meal: "Pasta"
                        )
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    VStack(alignment: .leading, spacing: 12) {

                        Text("Recent Activity")
                            .font(.title2.bold())

                        ActivityRow(
                            title: "Created June 1–7 Meal Plan"
                        )

                        ActivityRow(
                            title: "Added Chicken Wrap to Monday"
                        )

                        ActivityRow(
                            title: "Added Pasta to Friday Dinner"
                        )
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
            }
            .navigationTitle("Meal Plans")
        }
    }
}

struct DashboardCard: View {

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

struct UpcomingMealRow: View {

    let title: String
    let meal: String

    var body: some View {

        HStack {

            Image(systemName: "fork.knife.circle.fill")
                .font(.title2)
                .foregroundStyle(.green)

            VStack(alignment: .leading) {

                Text(title)
                    .fontWeight(.semibold)

                Text(meal)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct ActivityRow: View {

    let title: String

    var body: some View {

        HStack {

            Circle()
                .fill(.green)
                .frame(width: 10)

            Text(title)

            Spacer()

            Text("Today")
                .foregroundStyle(.secondary)
        }
    }
}

struct AlbumView: View {
    @State private var selectedPage = 0
    @State private var showSheet = false
    
    // MUST CHANGE AS CARDS ARE ADDED
    let cardCount = 2

    var body: some View {
        VStack {
            TabView(selection: $selectedPage) {

                // Card 1
                Button {
                    showSheet = true
                } label: {

                    VStack(alignment: .leading, spacing: 12) {

                        Text("June 15 – 21")
                            .font(.title.bold())
                            .foregroundStyle(.primary)

                        Label("Current Week", systemImage: "calendar")
                            .font(.caption)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(.green.opacity(0.15))
                            .foregroundStyle(.green)
                            .clipShape(Capsule())

                        Spacer()

                        VStack(alignment: .leading, spacing: 8) {

                            Text("0 Meals Planned")
                                .font(.headline)
                                .foregroundStyle(.primary)

                            ProgressView(value: 0, total: 21)

                            Text("0% Complete")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding()
                    .frame(width: 320, height: 260)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color(.systemBackground))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(Color(.systemGray5), lineWidth: 1)
                    )
                    .shadow(
                        color: .black.opacity(0.08),
                        radius: 8,
                        y: 4
                    )
                }
                .tag(0)
                .padding(.horizontal, 20)
                
                // Card 2 - not functional will update after card 1 is finished and good to go
                Button {
                    showSheet = true
                } label: {

                    VStack(alignment: .leading, spacing: 12) {

                        Text("June 22 – 28")
                            .font(.title.bold())
                            .foregroundStyle(.primary)

                        Label("Future Week", systemImage: "calendar")
                            .font(.caption)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(.orange.opacity(0.15))
                            .foregroundStyle(.orange)
                            .clipShape(Capsule())

                        Spacer()

                        VStack(alignment: .leading, spacing: 8) {

                            Text("Not Started")
                                .font(.headline)
                                .foregroundStyle(.primary)

                            ProgressView(value: 0, total: 21)

                            Text("0% Complete")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding()
                    .frame(width: 320, height: 260)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color(.systemBackground))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(Color(.systemGray5), lineWidth: 1)
                    )
                    .shadow(
                        color: .black.opacity(0.08),
                        radius: 8,
                        y: 4
                    )
                }
                .tag(1)
                .padding(.horizontal, 20)
                
            }
            .frame(height: 320)
            .tabViewStyle(.page)

            // Open sheet
            .sheet(isPresented: $showSheet) {
                SheetView()
            }

            HStack {
                
                Button {
                    withAnimation {
                        selectedPage -= 1
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }
                .opacity(selectedPage == 0 ? 0 : 1)
                .disabled(selectedPage == 0)
                .offset(x: selectedPage == 0 ? -20 : 0)
                .animation(.easeInOut(duration: 0.2), value: selectedPage)

                Spacer()

                Text("\(selectedPage + 1) / \(cardCount)")

                Spacer()

                Button {
                    withAnimation {
                        selectedPage += 1
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                }
                .opacity(selectedPage == cardCount - 1 ? 0 : 1)
                .disabled(selectedPage == cardCount - 1)
                .offset(x: selectedPage == cardCount - 1 ? 20 : 0)
                .animation(.easeInOut(duration: 0.2), value: selectedPage)
            }
            .padding(.horizontal)
        }
        .padding()
    }
}

struct SheetView: View {
    @Environment(\.dismiss) var dismiss

    // Days of the week
    let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    // Recipes - this is temp will throw in stuff before recording or whatever
    let recipes = ["Pasta", "Chicken Wrap", "Salad", "Rice Bowl", "Tacos"]

    // Stores all the selections
    @State private var mealsByDay: [String: DayMeals] = [
        "Monday": DayMeals(),
        "Tuesday": DayMeals(),
        "Wednesday": DayMeals(),
        "Thursday": DayMeals(),
        "Friday": DayMeals(),
        "Saturday": DayMeals(),
        "Sunday": DayMeals()
    ]

    var body: some View {
        VStack(spacing: 0) {

            // Top bar
            HStack {
                Spacer()

                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundStyle(.secondary)
                }
            }
            .padding()

            // Main stuff
            ScrollView {
                VStack(spacing: 12) {

                    ForEach(days, id: \.self) { day in

                        // Fix the option binding issue cus it couldn't unwrap. SO we just rebind it
                        let binding = Binding<DayMeals>(
                            get: { mealsByDay[day]! },
                            set: { mealsByDay[day] = $0 }
                        )

                        // First layer of different meals
                        DisclosureGroup {

                            // Breakfast
                            MealSection(
                                title: "Breakfast",
                                recipes: recipes,
                                // Just connect the meal section and the breakfast values so it updates and do that for every meal
                                selected: Binding(
                                    get: { binding.wrappedValue.breakfast },
                                    set: { binding.wrappedValue.breakfast = $0 }
                                )
                            )

                            // Lunch
                            MealSection(
                                title: "Lunch",
                                recipes: recipes,
                                selected: Binding(
                                    get: { binding.wrappedValue.lunch },
                                    set: { binding.wrappedValue.lunch = $0 }
                                )
                            )

                            // Dinner
                            MealSection(
                                title: "Dinner",
                                recipes: recipes,
                                selected: Binding(
                                    get: { binding.wrappedValue.dinner },
                                    set: { binding.wrappedValue.dinner = $0 }
                                )
                            )

                        } label: {
                            HStack {
                                Text(day)
                                    .font(.headline)

                                Spacer()

                                // Counter for # of meals might replace this but its cool for now
                                Text(summary(for: binding.wrappedValue))
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color(.systemGray6))
                            )
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.top, 10)
            }
        }
    }

    // Just count the # of meals selected for the label on top, again might be temp
    func summary(for day: DayMeals) -> String {
        let count = day.breakfast.count + day.lunch.count + day.dinner.count
        return "\(count) meals"
    }
}

// Model for each day to store an amount of meals
struct DayMeals {
    var breakfast: [String] = []
    var lunch: [String] = []
    var dinner: [String] = []
}

struct MealSection: View {
    let title: String
    let recipes: [String]
    @Binding var selected: [String]

    @State private var isExpanded: Bool = true

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {

            // HEADER
            Button {
                withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                    isExpanded.toggle()
                }
            } label: {
                HStack {
                    Text(title)
                        .font(.headline)

                    Spacer()

                    Text("\(selected.count)")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.secondary)

                    Image(systemName: "chevron.down")
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(.secondary)
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

            // ALWAYS IN VIEW HIERARCHY (important fix)
            VStack(spacing: 0) {
                ForEach(recipes, id: \.self) { recipe in
                    Button {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            toggle(recipe)
                        }
                    } label: {
                        HStack {
                            Text(recipe)
                                .foregroundStyle(.primary)

                            Spacer()

                            if selected.contains(recipe) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(.blue)
                            }
                        }
                        .padding(.vertical, 14)
                        .padding(.horizontal, 12)
                        .opacity(isExpanded ? 1 : 0)
                        .frame(height: isExpanded ? nil : 0) // collapses safely
                        .clipped()
                    }
                    .buttonStyle(.plain)
                    .disabled(!isExpanded) // prevents accidental taps when closed

                    if recipe != recipes.last {
                        Divider()
                            .padding(.leading, 12)
                            .opacity(isExpanded ? 1 : 0)
                    }
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.secondarySystemBackground))
            )
        }
        .padding(.vertical, 6)
    }

    private func toggle(_ recipe: String) {
        if let index = selected.firstIndex(of: recipe) {
            selected.remove(at: index)
        } else {
            selected.append(recipe)
        }
    }
}

#Preview {
    ContentView()
}
