import SwiftUI

struct FavoritesView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Your Favorites")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                Text("No favorites yet. Start exploring and add places to your favorites!")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .padding()

                Spacer()
            }
            .navigationTitle("Favorites")
        }
    }
}
