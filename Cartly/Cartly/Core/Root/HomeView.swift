//
//  HomeView.swift
//  Cartly
//
//  Created by Student on 2026-05-25.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @Environment(\.modelContext) private var context
    
    var body: some View {
        VStack {
            
            Button("baserecipe") {
                context.insert(Recipe(id: UUID(), title: "Pasta", icon: Image(systemName: "house"), mealType: "Dinner", calories: 0))
            }
            
            // Top bar
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(radius: 5)
                .frame(maxWidth: .infinity, maxHeight: 60)
                .overlay(
                    HStack {
                        Text("User Information")

                        Spacer()

                        Image(systemName: "person.fill")
                    }
                    .padding(.horizontal)
                )
                .padding()
            
            Spacer()
            
            // Bottom box with meal calendar
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(radius: 5)
                .frame(width: .infinity, height: 400)
                .padding()
                .overlay(
                    CalendarView()
                        .padding(40)
                    )
        }
    }
}

#Preview {
    HomeView()
}
