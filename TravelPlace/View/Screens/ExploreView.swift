import SwiftUI
import SwiftData

struct ExploreView: View {
    @Binding var favoritePlaces: [Destination]
    @Query(sort: \Destination.name) private var destinations: [Destination]
    @Environment(\.modelContext) private var context

    @State private var searchText1 = ""
    @State private var selectedCategory: String? = nil
    @State private var isPresentingNewDestinationView: Bool = false
    @State private var isPresentingEditView: Bool = false
    @State private var destinationToEdit: Destination? = nil

    let categories = ["All", "Nature", "Cities", "Museums"]

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                categoriesScrollView()
                searchBar()
                popularDestinationsHeader()
                destinationsGrid()

                Spacer()
            }
            .navigationTitle("Explore")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    addButton()
                }
            }
            .sheet(isPresented: $isPresentingNewDestinationView) {
                NewDestinationView { newDestination in
                    context.insert(newDestination)
                    try? context.save()
                }
            }
            .sheet(isPresented: $isPresentingEditView) {
                if let destination = destinationToEdit {
                    EditDestinationView(destination: destination) { updatedDestination in
                        saveDestination(updatedDestination)
                    }
                }
            }
        }
    }

    // Категории
    private func categoriesScrollView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(categories, id: \.self) { category in
                    Button(action: {
                        selectedCategory = category == "All" ? nil : category
                    }) {
                        Text(category)
                            .fontWeight(selectedCategory == category ? .bold : .regular)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(selectedCategory == category ? Color.blue : Color.gray.opacity(0.2))
                            .foregroundColor(selectedCategory == category ? .white : .primary)
                            .cornerRadius(10)
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
    }

    // Поисковая строка
    private func searchBar() -> some View {
        SearchBar(text: $searchText1, placeholder: "Search for places...")
            .padding(.horizontal)
    }

    // Заголовок для популярных направлений
    private func popularDestinationsHeader() -> some View {
        Text("Popular Destinations")
            .font(.title)
            .fontWeight(.bold)
            .padding(.horizontal)
            .padding(.top)
    }

    // Сетка направлений
    private func destinationsGrid() -> some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                ForEach(filteredDestinations) { destination in
                    DestinationCard(
                        destination: destination,
                        isFavorite: isFavorite(destination),
                        onFavoriteToggle: { toggleFavorite(destination) },
                        onEdit: { editDestination(destination) } // Добавлено onEdit
                    )
                }
            }
            .padding()
        }
    }

    // Кнопка добавления
    private func addButton() -> some View {
        Button(action: {
            isPresentingNewDestinationView = true
        }) {
            Image(systemName: "plus")
        }
    }

    // Фильтрация по категории
    private var categoryFilteredDestinations: [Destination] {
        if let category = selectedCategory {
            return destinations.filter { $0.category == category }
        } else {
            return destinations
        }
    }

    // Фильтрация по строке поиска
    private var searchFilteredDestinations: [Destination] {
        if searchText1.isEmpty {
            return categoryFilteredDestinations
        } else {
            return categoryFilteredDestinations.filter {
                $0.name.localizedCaseInsensitiveContains(searchText1) ||
                $0.details.localizedCaseInsensitiveContains(searchText1)
            }
        }
    }

    // Окончательный список фильтрованных направлений
    private var filteredDestinations: [Destination] {
        searchFilteredDestinations
    }

    // Проверка избранного
    private func isFavorite(_ destination: Destination) -> Bool {
        favoritePlaces.contains(where: { $0.id == destination.id })
    }

    // Добавление/удаление из избранного
    private func toggleFavorite(_ destination: Destination) {
        if let index = favoritePlaces.firstIndex(where: { $0.id == destination.id }) {
            favoritePlaces.remove(at: index)
        } else {
            favoritePlaces.append(destination)
        }
    }

    // Открытие редактирования
    private func editDestination(_ destination: Destination) {
        destinationToEdit = destination
        isPresentingEditView = true
    }

    // Сохранение изменений
    private func saveDestination(_ updatedDestination: Destination) {
        if let context = try? updatedDestination.modelContext {
            try? context.save()
        }
    }
}
