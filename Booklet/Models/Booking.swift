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

enum BookingStatus: String, Codable, CaseIterable {
    case pending
    case confirmed
    case checkedIn
    case checkedOut
    case cancelled
}

extension Booking {
    static func createRandomBookings(count: Int) -> [Booking] {
        let randomCustomerIds = (1...10).map { _ in UUID().uuidString }
        let randomRoomIds = (101...120).map { String($0) }

        return (0..<count).map { _ in
            let checkInDate = Date().addingTimeInterval(Double.random(in: 0...7776000)) // Random date within 90 days
            let checkOutDate = checkInDate.addingTimeInterval(Double.random(in: 86400...604800)) // 1-7 days stay

            return Booking(
                customerId: randomCustomerIds.randomElement()!,
                roomId: randomRoomIds.randomElement()!,
                checkInDate: checkInDate,
                checkOutDate: checkOutDate,
                numberOfGuests: Int.random(in: 1...4),
                status: BookingStatus.allCases.randomElement()!,
                totalPrice: Decimal(Int.random(in: 100...1000)),
                specialRequests: Bool.random() ? "Special request \(Int.random(in: 1...5))" : nil
            )
        }
    }
}
