import SwiftUI
import PhotosUI

struct NewPostView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var userManager: UserManager // Текущий пользователь через UserManager
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var selectedImage: UIImage? = nil
    @State private var isPresentingImagePicker = false

    var onSave: (Post) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title")) {
                    TextField("Enter post title", text: $title)
                }

                Section(header: Text("Content")) {
                    TextEditor(text: $content)
                        .frame(height: 150)
                }

                Section(header: Text("Image")) {
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .cornerRadius(10)
                    } else {
                        Text("No image selected")
                            .foregroundColor(.gray)
                    }

                    Button("Select Image") {
                        isPresentingImagePicker = true
                    }
                }

                Section(header: Text("Author")) {
                    if let currentUser = userManager.currentUser {
                        Text(currentUser.username)
                            .foregroundColor(.gray)
                    } else {
                        Text("Anonymous")
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("New Post")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        savePost()
                    }
                    .disabled(title.isEmpty || content.isEmpty)
                }
            }
            .sheet(isPresented: $isPresentingImagePicker) {
                ImagePicker(selectedImage: $selectedImage)
            }
        }
    }

    private func savePost() {
        guard let currentUser = userManager.currentUser else {
            print("Error: No current user.")
            return
        }

        let newPost = Post(
            title: title,
            content: content,
            imageName: saveImageLocally(selectedImage), // Сохраняем изображение и получаем имя файла
            author: currentUser.username
        )
        onSave(newPost)
        dismiss()
    }

    private func saveImageLocally(_ image: UIImage?) -> String {
        guard let image = image else { return "default" }
        let imageName = UUID().uuidString + ".jpg"
        if let data = image.jpegData(compressionQuality: 0.8) {
            let url = FileManager.default.temporaryDirectory.appendingPathComponent(imageName)
            try? data.write(to: url)
        }
        return imageName
    }
}
