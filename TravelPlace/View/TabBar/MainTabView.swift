import SwiftUI

struct MainTabView: View {
    @State private var favoritePlaces: [Destination] = [] // Общий список избранного
    
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
