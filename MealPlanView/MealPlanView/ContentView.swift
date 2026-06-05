import SwiftUI
import SwiftData

struct ContentView: View {

    var body: some View {
        VStack {
            
            // Temp top panel
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(radius: 5)
                .frame(maxWidth: .infinity, maxHeight: 60)
                .overlay(
                    HStack {
                        Text("Meal Plan View")
                    }
                    .padding(.horizontal)
                )
                .padding()
            
            AlbumView()
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
                    VStack(spacing: 2) {
                        Text("June")
                            .font(.headline)
                            .foregroundStyle(.secondary)

                        Text("1–7")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.primary)
                    }
                    .frame(width: 300, height: 300)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.gray.opacity(0.2))
                    )
                }
                .tag(0)
                .shadow(radius: 5)
                .padding(.horizontal, 20)
                
                // Card 2 - not functional will update after card 1 is finished and good to go
                RoundedRectangle(cornerRadius: 20)
                    .fill(.gray.opacity(0.2))
                    .frame(width: 300, height: 300)
                    .overlay(
                        VStack(spacing: 2) {
                            Text("June")
                                .font(.headline)
                                .foregroundStyle(.secondary)

                            Text("8-14")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                        }
                    )
                    .tag(1)
                    .shadow(radius: 5)
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

    // Use binding now so it can save
    @Binding var selected: [String]

    var body: some View {
        DisclosureGroup {
            
            // Theres a point where making this a grid with images is worth it but not there yet because thats a lot of work

            ForEach(recipes, id: \.self) { recipe in

                Button {
                    // Toggle on and off based off its already selected

                    if selected.contains(recipe) {
                        selected.removeAll { $0 == recipe }
                    } else {
                        selected.append(recipe)
                    }

                } label: {
                    HStack {
                        Text(recipe)
                            .foregroundStyle(.primary)
                            .padding(.vertical, 6)

                        Spacer()

                        // shows checkmark if selected
                        if selected.contains(recipe) {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.blue)
                        }
                    }
                }
                .padding(.horizontal)
            }

        } label: {
            HStack {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)

                Spacer()

                // shows number of selected recipes in this meal
                Text("\(selected.count)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, 6)
        }
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.systemGray5).opacity(0.5))
        )
    }
}

#Preview {
    ContentView()
}
