import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {

            ExploreView()
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass")
                }

            BlogView()
                .tabItem {
                    Label("Blog", systemImage: "text.bubble.fill")
                }

            FavoritesView()
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
