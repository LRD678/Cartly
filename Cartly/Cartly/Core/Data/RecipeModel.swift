// Recipe data model

import SwiftData
import SwiftUI

@Model
class Recipe {
    
    // Recipe id
    var id = UUID()
    
    // Parameters
    var title : String
    var icon : Image
    var mealType : String
    var calories : Int
    
    init(id: UUID = UUID(), title: String, icon: Image, mealType: String, calories: Int) {
        self.id = id
        self.title = title
        self.icon = icon
        self.mealType = mealType
        self.calories = calories
    }
}
