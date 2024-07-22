//
//  BookingCardView.swift
//  Booklet
//
//  Created by Erison Veshi on 22.7.24.
//

import SwiftUI

struct BookingCardView: View {
    
    // MARK: - Properties

    let booking: Booking

    // MARK: - View

    var body: some View {
        content
        .padding()
        .background(Color(.windowBackgroundColor))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

// MARK: - Content

private extension BookingCardView {
    var content: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("booking.card.roomNumber \(booking.roomId)")
                    .font(.headline)
                Spacer()
                StatusBadge(status: booking.status)
            }
            
            Divider()
            
            HStack {
                VStack(alignment: .leading) {
                    Label("booking.card.checkIn", systemImage: "calendar.badge.plus")
                    Text(booking.checkInDate, style: .date)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Label("booking.card.checkOut", systemImage: "calendar.badge.minus")
                    Text(booking.checkOutDate, style: .date)
                }
            }
            
            HStack {
                Label("booking.card.guestCount \(booking.numberOfGuests)", systemImage: "person.2")
                Spacer()
                Text(booking.totalPrice, format: .currency(code: "USD"))
                    .fontWeight(.bold)
            }
            
            if let specialRequests = booking.specialRequests {
                Text("booking.card.specialRequests")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(specialRequests)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    BookingCardView(booking: Booking(
        customerId: "123",
        roomId: "101",
        checkInDate: Date(),
        checkOutDate: Date().addingTimeInterval(86400 * 3),
        numberOfGuests: 2,
        status: .confirmed,
        totalPrice: 299.99,
        specialRequests: "Late check-out requested"
    ))
    .padding()
    .previewLayout(.sizeThatFits)
}
