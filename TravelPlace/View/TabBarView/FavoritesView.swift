import SwiftUI

struct FavoritesView: View {
    @State private var searchText: String = "" // Для строки поиска
    @State private var favoritePlaces: [Destination] = popularDestinations // Избранные места

    var body: some View {
        NavigationView {
            VStack {
                // Поисковая строка
                SearchBar(text: $searchText, placeholder: "Input text")

                ScrollView {
                    // Список избранных мест
                    ForEach(filteredFavorites, id: \.id) { place in
                        FavoritePlaceCard(place: place, onRemove: {
                            removeFromFavorites(place: place)
                        })
                    }
                }

                // Нижняя панель действий
                HStack {
                    Button(action: {
                        print("Remove from Favorites tapped")
                    }) {
                        Text("Remove from Favorites")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    Button(action: {
                        print("View Details tapped")
                    }) {
                        Text("View Details")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Favorite Places")
        }
    }

    // Фильтр по строке поиска
    private var filteredFavorites: [Destination] {
        if searchText.isEmpty {
            return favoritePlaces
        } else {
            return favoritePlaces.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    // Удаление из избранного
    private func removeFromFavorites(place: Destination) {
        if let index = favoritePlaces.firstIndex(where: { $0.id == place.id }) {
            favoritePlaces.remove(at: index)
        }
    }
}
