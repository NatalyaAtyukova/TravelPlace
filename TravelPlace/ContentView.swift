import SwiftUI


struct ContentView: View {
    @State private var searchText1 = ""
    @State private var searchText2 = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                VStack(spacing: 10) {
                    SearchBar(text: $searchText1, placeholder: "Search for places...")
                    SearchBar(text: $searchText2, placeholder: "Search for destinations, activities, or services")
                }
                .padding(.horizontal)

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

                BottomNavigationBar()
            }
            .navigationTitle("TravelPlace - Popular Destinations")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
