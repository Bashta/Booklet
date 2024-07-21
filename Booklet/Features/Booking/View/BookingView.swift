//
//  BookingView.swift
//  Booklet
//
//  Created by Erison Veshi on 20.7.24.
//

import SwiftUI

struct BookingView: View {
    
    // MARK: - VM
    
    @Environment(\.serviceLocator.bookingViewModel) private var bookingViewModel
    
    // MARK: - View
    
    var body: some View {
        VStack {
            List(bookingViewModel.bookings) { booking in
                BookingRow(booking: booking)
            }
            
            Button("booking.createRandom") {
                Task {
                    await bookingViewModel.createRandomBookings()
                }
            }
            .padding()
            .disabled(bookingViewModel.isLoading)
        }
        .overlay {
            if bookingViewModel.isLoading {
                ProgressView()
            }
        }
        .alert(isPresented: .init(get: { bookingViewModel.errorMessage != nil }, set: { _ in bookingViewModel.errorMessage = nil })) {
            Alert(title: Text("booking.error"), message: Text(bookingViewModel.errorMessage ?? ""))
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
