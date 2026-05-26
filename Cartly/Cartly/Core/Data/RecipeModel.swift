// Recipe data model

import SwiftUI

struct Recipe: Identifiable {
    
    // Recipe id
    let id = UUID()
    
    // Parameters
    let title : String
    let icon : Image
    let mealType : String
    let calories : Int
}
