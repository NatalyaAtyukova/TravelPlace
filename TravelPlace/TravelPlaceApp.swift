import SwiftUI
import SwiftData

@main
struct TravelPlaceApp: App {
    @StateObject private var userManager = UserManager() // Создание UserManager

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Destination.self,
            User.self,
            Post.self,
            Comment.self
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
                .modelContainer(sharedModelContainer) // Передача ModelContainer
                .environmentObject(userManager) // Передача UserManager
        }
    }
}
