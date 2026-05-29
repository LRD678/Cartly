// Recipe model

import Foundation
import SwiftData

@Model
class Recipe {
    
    // Parameters
    var id = UUID()
    
    var name : String
    var mealType : String
    var calories : Int
    
    // Data that we convert to image since stupid swift data cant store ui elements
    var imageData: Data?
    
    init(name: String, mealType: String, calories: Int, imageName : String) {
        self.name = name
        self.mealType = mealType
        self.calories = calories
        self.imageData = imageData
    }
}
