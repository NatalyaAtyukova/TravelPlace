import SwiftUI

struct UserGeneratedPostCard: View {
    let post: Post

    var body: some View {
        VStack(alignment: .leading) {
            Text(post.title)
                .font(.headline)
                .padding(.horizontal)

            Image(post.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .cornerRadius(10)
                .padding(.horizontal)

            Text(post.content)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.horizontal)

            VStack(alignment: .leading) {
                ForEach(post.comments, id: \.id) { comment in
                    Text("\(comment.author): \(comment.text)")
                        .font(.subheadline)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal)
        }
        .padding(.bottom)
    }
}   
