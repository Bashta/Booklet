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
    
    private var collectionPath: String {
        FirestoreCollection.Users.bookings.rawValue
    }
    
    // MARK: - Lifecycle
    
    init(authService: AuthServiceProtocol = AuthService()) {
        self.authService = authService
    }
}

// MARK: - CRUD

extension BookingService {
    
    func createBooking(_ booking: Booking) async throws {
            guard let userId = authService.getCurrentUserId() else {
                throw BookingError.userNotAuthenticated
            }
            
            do {
                let bookingReference = db.collection(collectionPath).document()
                var bookingData = try Firestore.Encoder().encode(booking)
                bookingData["userId"] = userId
                try await bookingReference.setData(bookingData)
            } catch {
                throw BookingError.failedToCreateBooking
            }
        }
        
        func getBookings() async throws -> [Booking] {
            guard let userId = authService.getCurrentUserId() else {
                throw BookingError.userNotAuthenticated
            }
            
            do {
                let snapshot = try await db.collection(collectionPath)
                    .whereField("userId", isEqualTo: userId)
                    .getDocuments()
                
                return try snapshot.documents.compactMap { document in
                    try document.data(as: Booking.self)
                }
            } catch {
                throw BookingError.failedToFetchBookings
            }
        }
        
        func updateBooking(_ booking: Booking) async throws {
            guard let bookingId = booking.id else {
                throw BookingError.invalidBookingData
            }
            
            do {
                let bookingReference = db.collection(collectionPath).document(bookingId)
                try bookingReference.setData(from: booking, merge: true)
            } catch {
                throw BookingError.failedToUpdateBooking
            }
        }
        
        func deleteBooking(_ bookingId: String) async throws {
            do {
                try await db.collection(collectionPath).document(bookingId).delete()
            } catch {
                throw BookingError.failedToDeleteBooking
            }
        }
}
