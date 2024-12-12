import SwiftUI

struct FeaturedPostCard: View {
    let post: Post

    var body: some View {
        VStack(alignment: .leading) {
            if let image = UIImage(named: post.imageName) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 100)
                    .cornerRadius(10)
                    .clipped()
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 100)
                    .cornerRadius(10)
                    .foregroundColor(.gray)
            }

            Text(post.title)
                .font(.headline)
                .lineLimit(1)

            Text("By \(post.author)")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(width: 150)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}
