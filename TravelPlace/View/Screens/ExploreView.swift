import SwiftUI

struct ExploreView: View {
    @Binding var favoritePlaces: [Destination] // Общий список избранного
    @State private var searchText1 = ""
    @State private var searchText2 = ""

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                // Search Bars
                VStack(spacing: 10) {
                    SearchBar(text: $searchText1, placeholder: "Search for places...")
                    SearchBar(text: $searchText2, placeholder: "Search for destinations, activities, or services")
                }
                .padding(.horizontal)

                // Popular Destinations Section
                Text("Popular Destinations")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .padding(.top)

                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(popularDestinations) { destination in
                            DestinationCard(destination: destination, isFavorite: isFavorite(destination)) {
                                toggleFavorite(destination)
                            }
                        }
                    }
                    .padding()
                }

                Spacer()
            }
            .navigationTitle("Explore - Popular Destinations")
        }
    }

    // Проверка, является ли место избранным
    private func isFavorite(_ destination: Destination) -> Bool {
        favoritePlaces.contains(where: { $0.id == destination.id })
    }

    // Добавление/удаление из избранного
    private func toggleFavorite(_ destination: Destination) {
        if let index = favoritePlaces.firstIndex(where: { $0.id == destination.id }) {
            favoritePlaces.remove(at: index) // Удаляем из избранного
        } else {
            favoritePlaces.append(destination) // Добавляем в избранное
        }
    }
}
