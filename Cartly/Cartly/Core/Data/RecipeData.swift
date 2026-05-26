// Data for all of the recipes. In future might have to change this to be importable but for now this is fine

import SwiftUI

let recipes: [Recipe] = [
    Recipe(
        title: "Chicken Alfredo",
        icon: Image(systemName: "fork.knife"),
        mealType: "Dinner",
        calories: 650
    ),
    Recipe(
        title: "Pancakes",
        icon: Image(systemName: "birthday.cake"),
        mealType: "Breakfast",
        calories: 400)
]
