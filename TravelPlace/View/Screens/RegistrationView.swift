import SwiftUI
import SwiftData

struct RegistrationView: View {
    @Environment(\.modelContext) private var context
    @State private var name: String = ""
    @State private var username: String = ""
    @State private var errorMessage: String? = nil
    @EnvironmentObject private var userManager: UserManager

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Register")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Form {
                    Section(header: Text("Full Name")) {
                        TextField("Enter your full name", text: $name)
                    }

                    Section(header: Text("Username")) {
                        TextField("Enter a username", text: $username)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }

                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                    }
                }

                Button(action: registerUser) {
                    Text("Register")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(name.isEmpty || username.isEmpty ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(name.isEmpty || username.isEmpty)

                Spacer()
            }
            .padding()
            .navigationTitle("Registration")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func registerUser() {
        let fetchDescriptor = FetchDescriptor<User>(predicate: #Predicate { $0.username == username })
        let existingUsers = try? context.fetch(fetchDescriptor)

        if let _ = existingUsers?.first {
            errorMessage = "This username is already taken. Please choose another."
            return
        }

        let newUser = User(name: name, username: username)
        context.insert(newUser)

        do {
            try context.save()
            userManager.currentUser = newUser
        } catch {
            errorMessage = "Failed to register. Please try again."
        }
    }
}
