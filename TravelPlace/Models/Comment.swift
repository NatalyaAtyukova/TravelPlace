import SwiftData
import Foundation

@Model
class Comment {
    @Attribute(.unique) var id: UUID = UUID()
    var text: String
    var author: String
    var date: Date

    init(text: String, author: String, date: Date = Date()) {
        self.text = text
        self.author = author
        self.date = date
    }
}
