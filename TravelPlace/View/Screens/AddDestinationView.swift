import SwiftUI

struct AddDestinationView: View {
    @Environment(\.modelContext) private var context

    @State private var name: String = ""
    @State private var details: String = ""
    @State private var imageName: String = ""
    @State private var category: String = ""
    @State private var rating: Double? = nil

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Enter destination name", text: $name)
                }
                Section(header: Text("Details")) {
                    TextEditor(text: $details)
                        .frame(height: 100)
                }
                Section(header: Text("Image Name")) {
                    TextField("Enter image name (e.g., eiffel_tower)", text: $imageName)
                }
                Section(header: Text("Category")) {
                    TextField("Enter category (e.g., Nature)", text: $category)
                }
                Section(header: Text("Rating")) {
                    TextField("Enter rating", value: $rating, format: .number)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Add Destination")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let newDestination = Destination(
                            name: name,
                            details: details,
                            imageName: imageName,
                            category: category,
                            rating: rating
                        )
                        context.insert(newDestination)
                        try? context.save()
                    }
                }
            }
        }
    }
}
