// Recipe data model

import SwiftUI

struct Recipe: Identifiable {
    
    // Recipe id
    let id = UUID()
    
    // Parameters
    let title : String
    let icon : String
    let mealType : String
    let calories : Int
}
