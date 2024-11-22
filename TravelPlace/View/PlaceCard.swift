import SwiftUI

struct PlaceCard: View {
    let place: Destination

    var body: some View {
        VStack(alignment: .leading) {
            Image(place.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 150)
                .cornerRadius(10)

            Text(place.name)
                .font(.headline)
                .padding(.top, 5)

            Text(place.details)
                .font(.subheadline)
                .foregroundColor(.gray)
                .lineLimit(2)

            if let rating = place.rating {
                Text("Rating: \(String(format: "%.1f", rating))/5")
                    .font(.footnote)
                    .padding(.top, 2)
            } else {
                Text("Rating: N/A")
                    .font(.footnote)
                    .padding(.top, 2)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}
