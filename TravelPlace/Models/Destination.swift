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

let popularDestinations = [
    Destination(name: "Paris, France", details: "Explore the romantic city of Paris and enjoy iconic landmarks like the Eiffel Tower.", imageName: "eiffel", rating: 4.8),
    Destination(name: "Beijing, China", details: "Discover the ancient wonders of the Great Wall and its breathtaking views.", imageName: "greatwall", rating: 4.7),
    Destination(name: "New York, USA", details: "Visit New York City and experience the vibrant culture and iconic sites.", imageName: "statueofliberty", rating: 4.9),
    Destination(name: "Sydney, Australia", details: "Enjoy the stunning architecture and lively atmosphere of Sydney.", imageName: "sydneyopera", rating: 4.6)
]
