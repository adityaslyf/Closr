
//
//  ClosrApp.swift
//  Closr
//
//  Created by Aditya Varshney on 02/05/26.
//

import SwiftUI
import SwiftData

@main
struct ClosrApp: App {

    // MARK: - SwiftData Container
    /// Lazily constructed shared model container.
    /// Add new model types to the Schema array as the app grows.
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            // e.g. UserProfile.self, Relationship.self
        ])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [config])
        } catch {
            fatalError("SwiftData: Could not create ModelContainer — \(error)")
        }
    }()

    // MARK: - Scene
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false

    var body: some Scene {
        WindowGroup {
            if hasCompletedOnboarding {
                MainTabView()
                    .preferredColorScheme(.light)
            } else {
                WelcomeView()
                    .preferredColorScheme(.light)
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
