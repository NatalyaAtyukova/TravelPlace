import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject private var userManager: UserManager // Использование UserManager
    @Query(filter: #Predicate<User> { !$0.username.isEmpty }) private var users: [User]

    var body: some View {
        Group {
            if let currentUser = userManager.currentUser {
                MainTabView()
                    .environmentObject(userManager) // Передача UserManager в дочерние представления
            } else if let firstUser = users.first {
                RegistrationView()
                    .onAppear {
                        userManager.currentUser = firstUser
                    }
            } else {
                RegistrationView()
            }
        }
    }
}
