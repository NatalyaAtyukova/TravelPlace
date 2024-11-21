//
//  Item.swift
//  TravelPlace
//
//  Created by Наталья Атюкова on 21.11.2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}