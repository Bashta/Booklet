//
//  Room.swift
//  Booklet
//
//  Created by Erison Veshi on 22.7.24.
//

import Foundation
import FirebaseFirestoreSwift

struct Room: Identifiable, Codable {
    @DocumentID var id: String?
    var uuid: UUID = .init()
    var number: String
    var type: String
    var capacity: Int
    var pricePerNight: Decimal
    var amenities: [String]
    var isAvailable: Bool = true
    var lastCleaned: Date?
}

extension Room {
    static var empty: Room {
        Room(
            number: "105",
            type: "Double",
            capacity: 2,
            pricePerNight: 120,
            amenities: ["Balcony", "Jacuzzi"]
        )
    }
}
