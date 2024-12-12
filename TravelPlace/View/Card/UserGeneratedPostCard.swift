import SwiftUI

struct UserGeneratedPostCard: View {
    let post: Post

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let image = loadImage(from: post.imageName) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(10)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(10)
                    .foregroundColor(.gray)
            }

            Text(post.title)
                .font(.headline)
                .lineLimit(1)

            Text(post.content)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(3)

            Text("@\(post.author)")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
        .shadow(radius: 3)
    }

    private func loadImage(from imageName: String) -> UIImage? {
        let url = FileManager.default.temporaryDirectory.appendingPathComponent(imageName)
        guard let data = try? Data(contentsOf: url) else { return nil }
        return UIImage(data: data)
    }
}
