//
//  TestNewConceptsApp.swift
//  TestNewConcepts
//
//  Created by Marco Gloria on 09/04/25.
//

import SwiftUI
import SwiftData

@main
struct TestNewConceptsApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    @StateObject var viewModel = ViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
        .environmentObject(viewModel)
    }
}
