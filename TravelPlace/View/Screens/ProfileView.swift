import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var userManager: UserManager // Работаем с текущим пользователем
    @State private var isPresentingEditProfileView = false

    var body: some View {
        NavigationView {
            VStack {
                if let currentUser = userManager.currentUser {
                    // Профильное изображение
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                        .padding()

                    Text(currentUser.name)
                        .font(.title)
                        .fontWeight(.bold)

                    Text("@\(currentUser.username)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.bottom)

                    Spacer()

                    // Кнопка для редактирования профиля
                    Button(action: {
                        isPresentingEditProfileView = true
                    }) {
                        Text("Edit Profile")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }

                    // Кнопка выхода
                    Button(action: logOut) {
                        Text("Log Out")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                } else {
                    Text("No user data available.")
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("Profile")
            .sheet(isPresented: $isPresentingEditProfileView) {
                if let currentUser = userManager.currentUser {
                    EditProfileView(currentUser: currentUser, userManager: userManager)
                }
            }
        }
    }

    private func logOut() {
        userManager.currentUser = nil
        print("User logged out.")
    }
}
