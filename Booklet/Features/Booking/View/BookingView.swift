//
//  BookingView.swift
//  Booklet
//
//  Created by Erison Veshi on 20.7.24.
//

import SwiftUI

struct BookingView: View {
    @Environment(\.serviceLocator.bookingViewModel) private var bookingViewModel
    
    var body: some View {
        List(bookingViewModel.bookings) { booking in
            BookingRow(booking: booking)
        }
        .task {
            await bookingViewModel.fetchBookings()
        }
    }
}

struct BookingRow: View {
    let booking: Booking
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Room: \(booking.roomId)")
            Text("Check-in: \(booking.checkInDate, style: .date)")
            Text("Check-out: \(booking.checkOutDate, style: .date)")
            Text("Status: \(booking.status.rawValue)")
        }
    }
}

#Preview {
    BookingView()
}
