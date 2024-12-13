import SwiftUI

class DestinationManager: ObservableObject {
    @Published var destinations: [Destination]

    init(destinations: [Destination]) {
        self.destinations = destinations
    }

    func addDestination(_ destination: Destination) {
        destinations.append(destination)
    }

    func updateDestination(_ destination: Destination) {
        if let index = destinations.firstIndex(where: { $0.id == destination.id }) {
            destinations[index] = destination
        }
    }

    func removeDestination(_ destination: Destination) {
        destinations.removeAll { $0.id == destination.id }
    }
}
