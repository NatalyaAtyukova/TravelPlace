import SwiftData
import Foundation

@Model
class User {
    @Attribute(.unique) var id: UUID = UUID() // Уникальный идентификатор
    @Attribute(.unique) var username: String // Уникальный логин пользователя
    var name: String // Полное имя пользователя
    var creationDate: Date // Дата регистрации

    init(name: String, username: String, creationDate: Date = Date()) {
        self.name = name
        self.username = username
        self.creationDate = creationDate
    }
}
