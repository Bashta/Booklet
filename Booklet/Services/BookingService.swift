//
//  BookingService.swift
//  Booklet
//
//  Created by Erison Veshi on 20.7.24.
//

import Foundation
import FirebaseFirestore

// MARK: - Interface

protocol BookingServiceProtocol {
    func createBooking(_ booking: Booking) async throws
    func getBookings() async throws -> [Booking]
    func updateBooking(_ booking: Booking) async throws
    func deleteBooking(_ bookingId: String) async throws
}

class BookingService: BookingServiceProtocol {
    
    // MARK: - Properties
    
    private let db = Firestore.firestore()
    private let authService: AuthServiceProtocol
    
    // MARK: - Lifecycle
    
    init(authService: AuthServiceProtocol = AuthService()) {
        self.authService = authService
    }
}

// MARK: - CRUD

extension BookingService {
    
    func createBooking(_ booking: Booking) async throws {
            guard let collection = hotelBookingsCollection else {
                throw BookingError.userNotAuthenticated
            }
            
            do {
                let bookingReference = collection.document()
                var bookingData = try Firestore.Encoder().encode(booking)
                bookingData["hotelId"] = authService.getCurrentUserId()
                try await bookingReference.setData(bookingData)
            } catch {
                throw BookingError.failedToCreateBooking
            }
        }
        
        func getBookings() async throws -> [Booking] {
            guard let collection = hotelBookingsCollection else {
                throw BookingError.userNotAuthenticated
            }
            
            do {
                let snapshot = try await collection.getDocuments()
                return try snapshot.documents.compactMap { document in
                    try document.data(as: Booking.self)
                }
            } catch {
                throw BookingError.failedToFetchBookings
            }
        }
        
        func updateBooking(_ booking: Booking) async throws {
            guard let bookingId = booking.id, let collection = hotelBookingsCollection else {
                throw BookingError.invalidBookingData
            }
            
            do {
                let bookingReference = collection.document(bookingId)
                try bookingReference.setData(from: booking, merge: true)
            } catch {
                throw BookingError.failedToUpdateBooking
            }
        }
        
        func deleteBooking(_ bookingId: String) async throws {
            guard let collection = hotelBookingsCollection else {
                throw BookingError.userNotAuthenticated
            }
            
            do {
                try await collection.document(bookingId).delete()
            } catch {
                throw BookingError.failedToDeleteBooking
            }
        }
}

// MARK: - Helpers

private extension BookingService {
    /// Provides access to the Firestore collection of bookings for the currently authenticated hotel.
    ///
    /// This computed property returns a `CollectionReference` for the hotel's bookings if a user is
    /// authenticated, or `nil` if no user is currently logged in.
    ///
    /// - Returns: A `CollectionReference` pointing to the hotel's bookings collection if authenticated, otherwise `nil`.
    var hotelBookingsCollection: CollectionReference? {
        guard let hotelId = authService.getCurrentUserId() else { return nil }
        return db.collection(FirestoreCollection.hotels.rawValue)
            .document(hotelId)
            .collection(FirestoreCollection.Hotel.bookings.rawValue)
    }
}
