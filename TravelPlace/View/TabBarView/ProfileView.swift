import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack {
                // Заглушка для изображения профиля
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .padding()

                Text("User Name")
                    .font(.title)
                    .fontWeight(.bold)

                Text("user@example.com")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom)

                Spacer()

                // Пример кнопки выхода
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
        }
    }
}
