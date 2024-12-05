import SwiftUI

struct FeaturedPostCard: View {
    let post: Post

    var body: some View {
        VStack(alignment: .leading) {
            Image(post.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 120)
                .cornerRadius(10)

            Text(post.title)
                .font(.headline)

            Text(post.content)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(2)

            Text(post.author)
                .font(.footnote)
                .foregroundColor(.gray)
        }
        .frame(width: 200)
    }
}
