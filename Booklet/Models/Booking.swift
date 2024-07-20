//
//  Booking.swift
//  Booklet
//
//  Created by Erison Veshi on 20.7.24.
//

import Foundation
import FirebaseFirestoreSwift

struct Booking: Identifiable, Codable {
    @DocumentID var id: String?
    let uuid: UUID = .init()
    var customerId: String
    var roomId: String
    var checkInDate: Date
    var checkOutDate: Date
    var numberOfGuests: Int
    var status: BookingStatus
    var totalPrice: Decimal
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
    var specialRequests: String?
}

enum BookingStatus: String, Codable {
    case pending
    case confirmed
    case checkedIn
    case checkedOut
    case cancelled
}
