import SwiftData
import Foundation

@Model
class Post {
    @Attribute(.unique) var id: UUID = UUID() // Уникальный идентификатор
    var title: String // Название поста
    var content: String // Содержимое поста
    var imageName: String // Название изображения
    var author: String // Автор поста
    @Relationship(deleteRule: .cascade) var comments: [Comment] // Связанные комментарии

    var creationDate: Date // Дата создания поста
    var lastModifiedDate: Date // Дата последнего изменения

    init(title: String, content: String, imageName: String, author: String, creationDate: Date = Date(), lastModifiedDate: Date = Date()) {
        self.title = title
        self.content = content
        self.imageName = imageName
        self.author = author
        self.comments = []
        self.creationDate = creationDate
        self.lastModifiedDate = lastModifiedDate
    }

    // Обновление поста
    func update(title: String? = nil, content: String? = nil, imageName: String? = nil, author: String? = nil) {
        if let newTitle = title {
            self.title = newTitle
        }
        if let newContent = content {
            self.content = newContent
        }
        if let newImageName = imageName {
            self.imageName = newImageName
        }
        if let newAuthor = author {
            self.author = newAuthor
        }
        self.lastModifiedDate = Date() // Обновляем дату изменения
    }
}
