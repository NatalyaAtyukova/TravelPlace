import SwiftUI

struct EditDestinationView: View {
    @Environment(\.dismiss) var dismiss
    @State private var destination: Destination
    var onSave: (Destination) -> Void

    init(destination: Destination, onSave: @escaping (Destination) -> Void) {
        _destination = State(initialValue: destination)
        self.onSave = onSave
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Enter destination name", text: $destination.name)
                }

                Section(header: Text("Details")) {
                    TextEditor(text: $destination.details)
                        .frame(height: 100)
                }

                Section(header: Text("Image Name")) {
                    TextField("Enter image name (e.g., eiffel_tower)", text: $destination.imageName)
                }

                Section(header: Text("Category")) {
                    TextField("Enter category (e.g., Nature)", text: $destination.category)
                }

                Section(header: Text("Rating")) {
                    TextField("Enter rating", value: $destination.rating, format: .number)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Edit Destination")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        onSave(destination)
                        dismiss()
                    }
                    .disabled(destination.name.isEmpty || destination.details.isEmpty)
                }
            }
        }
    }
}
