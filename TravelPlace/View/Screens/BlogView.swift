import SwiftUI
import SwiftData

struct BlogView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject private var userManager: UserManager
    @Query(sort: \Post.creationDate, order: .reverse) private var allPosts: [Post]

    @State private var selectedTab: String = "home"
    @State private var isPresentingNewPostView = false
    @State private var searchText: String = ""

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Search Bar
                    SearchBar(text: $searchText, placeholder: "Search posts or topics...")

                    // Tabs: Home / Explore
                    HStack {
                        Button(action: {
                            withAnimation {
                                selectedTab = "home"
                            }
                        }) {
                            Text("home")
                                .font(.headline)
                                .fontWeight(selectedTab == "home" ? .bold : .regular)
                                .foregroundColor(selectedTab == "home" ? .blue : .gray)
                                .padding(.bottom, 5)
                                .overlay(
                                    selectedTab == "home" ?
                                        Rectangle()
                                            .frame(height: 2)
                                            .foregroundColor(.blue)
                                            .offset(y: 10)
                                        : nil,
                                    alignment: .bottom
                                )
                        }
                        Spacer()
                        Button(action: {
                            withAnimation {
                                selectedTab = "explore"
                            }
                        }) {
                            Text("explore")
                                .font(.headline)
                                .fontWeight(selectedTab == "explore" ? .bold : .regular)
                                .foregroundColor(selectedTab == "explore" ? .blue : .gray)
                                .padding(.bottom, 5)
                                .overlay(
                                    selectedTab == "explore" ?
                                        Rectangle()
                                            .frame(height: 2)
                                            .foregroundColor(.blue)
                                            .offset(y: 10)
                                        : nil,
                                    alignment: .bottom
                                )
                        }
                    }
                    .padding(.horizontal)

                    // Tab Content
                    if selectedTab == "home" {
                        homeTabContent()
                    } else if selectedTab == "explore" {
                        exploreTabContent()
                    }
                }
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
                    savePost(newPost)
                }
                .environmentObject(userManager)
            }
        }
    }

    private func savePost(_ post: Post) {
        context.insert(post)
        try? context.save()
    }

    // Home Tab Content
    @ViewBuilder
    private func homeTabContent() -> some View {
        // Featured Posts Section
        Text("Featured Posts")
            .font(.title3)
            .fontWeight(.semibold)
            .padding(.horizontal)

        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(allPosts.prefix(3)) { post in
                    FeaturedPostCard(post: post)
                }
            }
            .padding(.horizontal)
        }

        // User Generated Posts Section
        Text("My Posts")
            .font(.title3)
            .fontWeight(.semibold)
            .padding(.horizontal)

        VStack(spacing: 15) {
            ForEach(myPosts) { post in
                UserGeneratedPostCard(post: post)
                    .padding(.horizontal)
            }
        }
    }

    // Explore Tab Content
    @ViewBuilder
    private func exploreTabContent() -> some View {
        Text("Explore Posts")
            .font(.title3)
            .fontWeight(.semibold)
            .padding(.horizontal)

        VStack(spacing: 15) {
            ForEach(filteredOtherPosts) { post in
                UserGeneratedPostCard(post: post)
                    .padding(.horizontal)
            }
        }
    }

    // Посты текущего пользователя
    private var myPosts: [Post] {
        guard let currentUser = userManager.currentUser else { return [] }
        return allPosts.filter { $0.author == currentUser.username }
    }

    // Посты других пользователей
    private var otherPosts: [Post] {
        guard let currentUser = userManager.currentUser else { return allPosts }
        return allPosts.filter { $0.author != currentUser.username }
    }

    // Фильтрованные посты других пользователей
    private var filteredOtherPosts: [Post] {
        guard !searchText.isEmpty else { return otherPosts }
        return otherPosts.filter { post in
            post.title.localizedCaseInsensitiveContains(searchText) ||
            post.content.localizedCaseInsensitiveContains(searchText) ||
            post.author.localizedCaseInsensitiveContains(searchText)
        }
    }
}
