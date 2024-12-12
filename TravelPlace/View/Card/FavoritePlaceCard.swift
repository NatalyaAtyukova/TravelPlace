import SwiftUI

struct FavoritePlaceCard: View {
    let place: Destination
    let onRemove: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Изображение места
            Image(place.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 150)
                .cornerRadius(10)

            // Название и описание
            VStack(alignment: .leading, spacing: 5) {
                Text(place.name)
                    .font(.headline)

                Text(place.details)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }

            // Кнопка удаления
            Button(action: onRemove) {
                Text("Remove from Favorites")
                    .font(.footnote)
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray6))
                    .foregroundColor(.blue)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
        .padding(.horizontal)
    }
}
