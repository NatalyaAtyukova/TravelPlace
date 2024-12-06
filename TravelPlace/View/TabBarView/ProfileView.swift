import SwiftUI

struct ProfileView: View {
    @State private var fullName: String = "John Doe"
    @State private var nickname: String = "johnd"
    @State private var profileImage: String = "person.circle.fill"
    @State private var isPresentingEditProfileView = false

    var body: some View {
        NavigationView {
            VStack {
                // Профильное изображение
                Image(systemName: profileImage)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .padding()

                Text(fullName)
                    .font(.title)
                    .fontWeight(.bold)

                Text("@\(nickname)")
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
                Button(action: {
                    print("Log Out Tapped")
                }) {
                    Text("Log Out")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            .navigationTitle("Profile")
            .sheet(isPresented: $isPresentingEditProfileView) {
                EditProfileView(fullName: $fullName, nickname: $nickname, profileImage: $profileImage)
            }
        }
    }
}
