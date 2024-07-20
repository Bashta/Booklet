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
