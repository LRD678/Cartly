//
//  RecipePopup.swift
//  Cartly
//
//  Created by Student on 2026-05-25.
//

import SwiftUI

// Popup for adding / editing recipes

struct RecipePopup: View {
    
    @Binding var showPopup: Bool
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            // Placeholder text
            Text("Centered Popup")
                .font(.title2)
            
            // Close popup button
            Button("Close") {
                showPopup = false
            }
        }
        .padding()
        
        // Temp dimensions
        .frame(width: 300, height: 500)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 20)
    }
}
