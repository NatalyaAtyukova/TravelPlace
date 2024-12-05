import SwiftUI

struct ExploreView: View {
    @State private var searchText1 = ""
    @State private var searchText2 = ""

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                // Search Bars
                VStack(spacing: 10) {
                    SearchBar(text: $searchText1, placeholder: "Search for places...")
                    SearchBar(text: $searchText2, placeholder: "Search for destinations, activities, or services")
                }
                .padding(.horizontal)

                // Popular Destinations Section
                Text("Popular Destinations")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .padding(.top)

                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(popularDestinations) { destination in
                            DestinationCard(destination: destination)
                        }
                    }
                    .padding()
                }

                Spacer()
            }
            .navigationTitle("Explore - Popular Destinations")
        }
    }
}
