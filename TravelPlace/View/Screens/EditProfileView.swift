import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var userManager: UserManager // Для обновления текущего пользователя
    @State private var fullName: String
    @State private var nickname: String

    init(currentUser: User, userManager: UserManager) {
        self.userManager = userManager
        _fullName = State(initialValue: currentUser.name)
        _nickname = State(initialValue: currentUser.username)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Full Name")) {
                    TextField("Enter your full name", text: $fullName)
                }

                Section(header: Text("Username")) {
                    TextField("Enter your username", text: $nickname)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
            }
            .navigationTitle("Edit Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveChanges()
                        dismiss()
                    }
                }
            }
        }
    }

    private func saveChanges() {
        guard let currentUser = userManager.currentUser else { return }
        currentUser.name = fullName
        currentUser.username = nickname

        do {
            try userManager.saveContext()
        } catch {
            print("Failed to save changes: \(error)")
        }
    }
}
