import SwiftUI
import SwiftData

struct MainTabView: View {
    @Query(sort: \Destination.name) private var destinations: [Destination] // Загружаем данные из SwiftData
    @State private var favoritePlaces: [Destination] = [] // Для избранных мест

    var body: some View {
        TabView {
            ExploreView(favoritePlaces: $favoritePlaces)
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass")
                }

            BlogView()
                .tabItem {
                    Label("Blog", systemImage: "text.bubble.fill")
                }

            FavoritesView(favoritePlaces: $favoritePlaces)
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
}
