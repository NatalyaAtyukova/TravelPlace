import SwiftData
import Foundation

@Model
class Destination {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    var details: String
    var imageName: String
    var rating: Double?

    init(name: String, details: String, imageName: String, rating: Double? = nil) {
        self.name = name
        self.details = details
        self.imageName = imageName
        self.rating = rating
    }
}
