//
//  CartlyReworkApp.swift
//  CartlyRework
//
//  Created by Student on 2026-05-28.
//

import SwiftUI
import SwiftData

@main
struct CartlyReworkApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: Recipe.self)
    }
}
