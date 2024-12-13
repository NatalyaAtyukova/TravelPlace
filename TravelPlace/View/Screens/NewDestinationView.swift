import SwiftUI

struct NewDestinationView: View {
    @Environment(\.dismiss) var dismiss

    @State private var name: String = ""
    @State private var details: String = ""
    @State private var imageName: String = ""
    @State private var category: String = ""
    @State private var rating: Double? = nil
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented: Bool = false

    var onSave: (Destination) -> Void

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

                Section(header: Text("Image")) {
                    Button(action: {
                        isImagePickerPresented = true
                    }) {
                        HStack {
                            Text(selectedImage == nil ? "Choose Image" : "Change Image")
                            Spacer()
                            if let image = selectedImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            }
                        }
                    }
                }

                Section(header: Text("Category")) {
                    TextField("Enter category (e.g., Nature)", text: $category)
                }

                Section(header: Text("Rating")) {
                    TextField("Enter rating (optional)", value: $rating, format: .number)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Add New Destination")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let newDestination = Destination(
                            name: name,
                            details: details,
                            imageName: imageName.isEmpty ? saveImage() : imageName,
                            category: category,
                            rating: rating
                        )
                        onSave(newDestination)
                        dismiss()
                    }
                    .disabled(name.isEmpty || details.isEmpty || category.isEmpty)
                }
            }
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(selectedImage: $selectedImage)
            }
        }
    }

    // Сохраняем изображение и возвращаем его имя
    private func saveImage() -> String {
        guard let image = selectedImage,
              let data = image.jpegData(compressionQuality: 0.8) else {
            return ""
        }
        let filename = UUID().uuidString + ".jpg"
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(filename)
        try? data.write(to: path)
        return filename
    }
}
