import SwiftUI

struct ExploreView: View {
    @State private var searchText1 = ""
    @State private var searchText2 = ""
    @State private var selectedCategory: String? = nil

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Explore")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .padding(.top)

                VStack(spacing: 10) {
                    SearchBar(text: $searchText1, placeholder: "Search for places...")
                    SearchBar(text: $searchText2, placeholder: "Search for destinations, activities, or services")
                }
                .padding(.horizontal)

                CategoryFilterView(selectedCategory: $selectedCategory)
                    .padding(.horizontal)
                    .padding(.top)

                Text("Recommended Places")
                    .font(.headline)
                    .padding(.horizontal)
                    .padding(.top)

                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(popularDestinations) { place in
                            PlaceCard(place: place)
                        }
                    }
                    .padding()
                }

                VStack {
                    Text("Connect with Friends")
                        .font(.headline)
                        .padding(.bottom, 5)

                    HStack(spacing: 20) {
                        ActionButton(title: "Invite Friends", icon: "person.3.fill")
                        ActionButton(title: "Share Plan", icon: "square.and.arrow.up")
                    }
                }
                .padding()

                Spacer()

                BottomNavigationBar()
            }
            .navigationBarTitle("Explore", displayMode: .inline)
        }
    }
}
