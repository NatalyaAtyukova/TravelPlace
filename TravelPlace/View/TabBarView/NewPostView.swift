import SwiftUI

struct NewPostView: View {
    @Environment(\.dismiss) var dismiss
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var imageName: String = ""
    @State private var author: String = "Anonymous" // По умолчанию

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

                Section(header: Text("Image Name")) {
                    TextField("Enter image name (e.g., eiffel_tower)", text: $imageName)
                }

                Section(header: Text("Author")) {
                    TextField("Enter your name", text: $author)
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
                        let newPost = Post(
                            title: title,
                            content: content,
                            imageName: imageName.isEmpty ? "default" : imageName,
                            author: author
                        )
                        onSave(newPost)
                        dismiss()
                    }
                    .disabled(title.isEmpty || content.isEmpty)
                }
            }
        }
    }
}
