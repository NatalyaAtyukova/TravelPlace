//
//  TravelPlaceApp.swift
//  TravelPlace
//
//  Created by Наталья Атюкова on 21.11.2024.
//

import SwiftUI
import SwiftData

@main
struct TravelPlaceApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Destination.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
