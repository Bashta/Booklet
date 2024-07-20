//
//  BookingService.swift
//  Booklet
//
//  Created by Erison Veshi on 20.7.24.
//

import Foundation

// MARK: - Interface

protocol BookingServiceProtocol {
    func createBooking(_ booking: Booking) async throws
    func getBookings() async throws -> [Booking]
    func updateBooking(_ booking: Booking) async throws
    func deleteBooking(_ bookingId: String) async throws
}

class BookingService: BookingServiceProtocol {
    
    // MARK: - Public interface

    func createBooking(_ booking: Booking) async throws {
        
    }
    
    func getBookings() async throws -> [Booking] {
        []
    }
    
    func updateBooking(_ booking: Booking) async throws {
        
    }
    
    func deleteBooking(_ bookingId: String) async throws {
        
    }
}
