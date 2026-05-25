import Foundation
import Combine

class AppState: ObservableObject {
    @Published var showPopup = false
    @Published var selectedRecipe = ""
}
