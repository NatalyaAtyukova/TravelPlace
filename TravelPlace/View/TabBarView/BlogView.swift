import SwiftUI

struct BlogView: View {
    @State private var searchText: String = ""
    @State private var selectedTab: String = "home" // "home" или "explore"
    @State private var userPosts: [Post] = [] // Хранение пользовательских постов
    @State private var isPresentingNewPostView = false // Контроль отображения экрана создания поста

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

                    if userPosts.isEmpty {
                        Text("No posts yet. Be the first to share your experience!")
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                    } else {
                        ForEach(userPosts, id: \.id) { post in
                            UserGeneratedPostCard(post: post)
                        }
                        .padding(.horizontal)
                    }
                }

                Spacer()
            }
            .navigationTitle("Blog View")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPresentingNewPostView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isPresentingNewPostView) {
                NewPostView { newPost in
                    userPosts.append(newPost) // Добавляем новый пост
                }
            }
        }
    }
}
