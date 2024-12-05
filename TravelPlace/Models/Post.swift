import SwiftData
import Foundation

@Model
class Post {
    @Attribute(.unique) var id: UUID = UUID()
    var title: String
    var content: String
    var imageName: String
    var author: String
    @Relationship(deleteRule: .cascade) var comments: [Comment]

    init(title: String, content: String, imageName: String, author: String) {
        self.title = title
        self.content = content
        self.imageName = imageName
        self.author = author
        self.comments = []
    }
}
