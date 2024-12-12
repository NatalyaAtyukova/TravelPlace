import SwiftUI

class UserManager: ObservableObject {
    @Published var currentUser: User?

    func saveContext() throws {
        guard let context = currentUser?.modelContext else { return }
        try context.save()
    }
}
