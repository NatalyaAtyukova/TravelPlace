import SwiftUI
import SwiftData

struct BlogView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject private var userManager: UserManager
    @Query(sort: \Post.creationDate, order: .reverse) private var allPosts: [Post]

    @State private var selectedTab: String = "home"
    @State private var isPresentingNewPostView = false

    var body: some View {
        NavigationView {
            ScrollView { // Обертка для вертикальной прокрутки
                VStack(spacing: 20) {
                    // Search Bar
                    SearchBar(text: .constant(""), placeholder: "Search posts or topics...")

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

                    if selectedTab == "home" {
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
                        Text("User Generated Posts")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.horizontal)

                        VStack(spacing: 15) {
                            ForEach(allPosts) { post in
                                UserGeneratedPostCard(post: post)
                                    .padding(.horizontal)
                            }
                        }
                    } else if selectedTab == "explore" {
                        // Explore Tab Content
                        Text("Explore Content")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                            .padding(.top)
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
}
