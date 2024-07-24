//
//  BookingService.swift
//  Booklet
//
//  Created by Erison Veshi on 20.7.24.
//

import Foundation
import FirebaseFirestore

class BookingService {
    
    // MARK: - Properties
    
    private let db = Firestore.firestore()
    private let authService: AuthServiceProtocol
    private let entityName: String = "Booking"

    // MARK: - Lifecycle
    
    init(authService: AuthServiceProtocol = AuthService()) {
        self.authService = authService
    }
}

// MARK: - CRUD

extension BookingService: CRUDServiceProtocol {
    
    typealias Entity = Booking

    func create(_ entity: Booking) async throws {
        try await performServiceCall(entity: entityName) {
            guard let collection = self.hotelBookingsCollection else {
                throw ServiceError.userNotAuthenticated
            }
            let roomReference = collection.document()
            try roomReference.setData(from: entity)
        }
    }
    
    func read() async throws -> [Booking] {
        try await performServiceCall(entity: entityName) {
            guard let collection = self.hotelBookingsCollection else {
                throw ServiceError.userNotAuthenticated
            }
            let snapshot = try await collection.getDocuments()
            return try snapshot.documents.compactMap { try $0.data(as: Booking.self) }
        }
    }
    
    func update(_ entity: Booking) async throws {
        try await performServiceCall(entity: entityName) {
            guard let roomId = entity.id, let collection = self.hotelBookingsCollection else {
                throw ServiceError.invalidData(self.entityName)
            }
            let roomReference = collection.document(roomId)
            try roomReference.setData(from: entity, merge: true)
        }
    }
        
    func delete(_ id: String) async throws {
        try await performServiceCall(entity: entityName) {
            guard let collection = self.hotelBookingsCollection else {
                throw ServiceError.userNotAuthenticated
            }
            try await collection.document(id).delete()
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
