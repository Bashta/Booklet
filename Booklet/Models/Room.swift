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
    let uuid: UUID = .init()
    var number: String
    var type: RoomType
    var capacity: Int
    var pricePerNight: Decimal
    var amenities: [String]
    var isAvailable: Bool = true
    var lastCleaned: Date?
    
    enum RoomType: String, Codable, CaseIterable {
        case single
        case double
        case suite
        case deluxe
    }
}

extension Room {
    static var empty: Room {
        Room(number: "", type: .single, capacity: 1, pricePerNight: 0, amenities: [])
    }
}
