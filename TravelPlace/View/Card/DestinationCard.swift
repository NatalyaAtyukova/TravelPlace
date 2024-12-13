import SwiftUI

struct DestinationCard: View {
    let destination: Destination
    let isFavorite: Bool
    let onFavoriteToggle: () -> Void
    let onEdit: () -> Void // Добавляем замыкание для редактирования

    var body: some View {
        VStack(alignment: .leading) {
            Image(destination.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 150)
                .cornerRadius(10)
                .clipped()

            Text(destination.name)
                .font(.headline)
                .lineLimit(1)

            Text(destination.details)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(2)

            HStack {
                Button(action: onFavoriteToggle) {
                    Text(isFavorite ? "Remove from Favorites" : "Add to Favorites")
                        .font(.footnote)
                        .foregroundColor(isFavorite ? .red : .blue)
                        .padding(.top, 5)
                }

                Button(action: onEdit) {
                    Text("Edit")
                        .font(.footnote)
                        .foregroundColor(.green)
                        .padding(.top, 5)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
