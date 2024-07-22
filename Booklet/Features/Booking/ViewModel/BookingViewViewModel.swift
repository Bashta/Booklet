//
//  BookingViewViewModel.swift
//  Booklet
//
//  Created by Erison Veshi on 20.7.24.
//

import Foundation

@Observable
class BookingViewViewModel {
    
    // MARK: - Properties
    
    private let bookingService: BookingServiceProtocol
    
    var bookings: [Booking] = []
    var isLoading = false
    var errorMessage: String?
    
    // MARK: - Lifecycle
    
    init(bookingService: BookingServiceProtocol = BookingService()) {
        self.bookingService = bookingService
    }
}

// MARK: - Backend Calls

extension BookingViewViewModel {
    func fetchBookings() async {
        isLoading = true
        do {
            bookings = try await bookingService.getBookings()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}

// MARK: - Helpers

extension BookingViewViewModel {
    // TODO: - Remove this once creating
    func createRandomBookings(count: UInt = 10) async {
        isLoading = true
        let randomBookings = Booking.createRandomBookings(count: 10)
        do {
            for booking in randomBookings {
                try await bookingService.createBooking(booking)
            }
            await fetchBookings()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
