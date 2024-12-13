import SwiftData
import Foundation

@Model
class Destination {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    var details: String
    var imageName: String
    var rating: Double?
    var category: String // Новое поле для категории

    init(name: String, details: String, imageName: String, category: String, rating: Double? = nil) {
        self.name = name
        self.details = details
        self.imageName = imageName
        self.category = category
        self.rating = rating
    }
}
