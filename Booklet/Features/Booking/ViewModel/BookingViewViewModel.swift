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
    
    private let bookingService: BookingService

    var bookings: [Booking] = []
    var isLoading = false
    var errorMessage: String?
    
    // MARK: - Lifecycle
    
    init(bookingService: BookingService = BookingService()) {
        self.bookingService = bookingService
    }
}

// MARK: - Backend Calls

@MainActor
extension BookingViewViewModel {
    func fetchBookings() async {
        isLoading = true
        do {
            bookings = try await bookingService.read()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func addBooking(_ booking: Booking) async {
        isLoading = true
        do {
            try await bookingService.create(booking)
            await fetchBookings()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func updateBooking(_ booking: Booking) async {
        isLoading = true
        do {
            try await bookingService.update(booking)
            await fetchBookings()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func deleteBooking(withId id: String) async {
        isLoading = true
        do {
            try await bookingService.delete(id)
            await fetchBookings()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}

// MARK: - Helpers
@MainActor
extension BookingViewViewModel {
    // TODO: - Remove this once creating new bookings is streamlined
    func createRandomBookings(count: UInt = 10) async {
        isLoading = true
        let randomBookings = Booking.createRandomBookings(count: 10)
        do {
            for booking in randomBookings {
                try await bookingService.create(booking)
            }
            await fetchBookings()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
