import SwiftUI

struct ActionButton: View {
    let title: String
    let icon: String

    var body: some View {
        Button(action: {
            // Логика для кнопки
        }) {
            HStack {
                Image(systemName: icon)
                Text(title)
            }
            .font(.subheadline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue.opacity(0.1))
            .cornerRadius(10)
        }
    }
}
