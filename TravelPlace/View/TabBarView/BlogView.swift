import SwiftUI

struct BlogView: View {
    @State private var searchText: String = ""
    @State private var selectedTab: String = "home" // "home" или "explore"

    let featuredPosts = samplePosts

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                // Search Bar
                SearchBar(text: $searchText, placeholder: "Search posts or topics...")

                // Tabs: Home / Explore
                HStack {
                    Button(action: {
                        selectedTab = "home"
                    }) {
                        Text("home")
                            .fontWeight(selectedTab == "home" ? .bold : .regular)
                            .foregroundColor(selectedTab == "home" ? .blue : .gray)
                            .padding(.bottom, 5)
                    }
                    Spacer()
                    Button(action: {
                        selectedTab = "explore"
                    }) {
                        Text("explore")
                            .fontWeight(selectedTab == "explore" ? .bold : .regular)
                            .foregroundColor(selectedTab == "explore" ? .blue : .gray)
                            .padding(.bottom, 5)
                    }
                }
                .padding(.horizontal)
                .overlay(
                    Divider()
                        .padding(.horizontal, -20),
                    alignment: .bottom
                )

                // Featured Posts Section
                Text("Featured Posts")
                    .font(.headline)
                    .padding(.horizontal)
                    .padding(.top)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(featuredPosts, id: \.id) { post in
                            FeaturedPostCard(post: post)
                        }
                    }
                    .padding(.horizontal)
                }

                // User Generated Posts Section
                VStack(alignment: .leading) {
                    Text("User Generated Posts")
                        .font(.headline)
                        .padding(.horizontal)

                    // Здесь можно добавить пользовательские посты
                }
            }
            .navigationTitle("Blog View")
        }
    }
}
