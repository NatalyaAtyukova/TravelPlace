import SwiftUI

struct DestinationCard: View {
    let destination: Destination

    var body: some View {
        VStack(alignment: .leading) {
            Image(destination.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 120)
                .cornerRadius(10)

            Text(destination.name)
                .font(.headline)
                .padding(.top, 5)

            Text(destination.details)
                .font(.subheadline)
                .foregroundColor(.gray)
                .lineLimit(2)

            Button(action: {
                // Логика добавления в избранное
            }) {
                Text("Add to Favorites")
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .padding(.vertical, 5)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.blue, lineWidth: 1)
                    )
            }
            .padding(.top, 5)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}

struct DestinationCard_Previews: PreviewProvider {
    static var previews: some View {
        DestinationCard(destination: popularDestinations[0])
            .previewLayout(.sizeThatFits)
    }
}
