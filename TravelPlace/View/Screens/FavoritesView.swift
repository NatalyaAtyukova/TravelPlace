import SwiftUI

struct FavoritesView: View {
    @Binding var favoritePlaces: [Destination] // Общий список избранного
    @State private var searchText: String = "" // Для строки поиска

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

                Spacer()
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
