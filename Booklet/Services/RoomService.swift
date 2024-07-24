//
//  RoomService.swift
//  Booklet
//
//  Created by Erison Veshi on 22.7.24.
//

import Foundation
import FirebaseFirestore

class RoomService {
    
    // MARK: - Properties
    
    private let db = Firestore.firestore()
    private let authService: AuthServiceProtocol
    private let entityName: String = "Room"
    // MARK: - Lifecycle

    init(authService: AuthServiceProtocol = AuthService()) {
        self.authService = authService
    }
}

// MARK: - CRUD

extension RoomService: CRUDServiceProtocol {

    typealias Entity = Room

    func create(_ entity: Room) async throws {
        try await performServiceCall(entity: entityName) {
            guard let collection = self.hotelRoomsCollection else {
                throw ServiceError.userNotAuthenticated
            }
            let roomReference = collection.document()
            try roomReference.setData(from: entity)
        }
    }
    
    func read() async throws -> [Room] {
        try await performServiceCall(entity: entityName) {
            guard let collection = self.hotelRoomsCollection else {
                throw ServiceError.userNotAuthenticated
            }
            let snapshot = try await collection.getDocuments()
            return try snapshot.documents.compactMap { try $0.data(as: Room.self) }
        }
    }
    
    func update(_ entity: Room) async throws {
        try await performServiceCall(entity: entityName) {
            guard let roomId = entity.id, let collection = self.hotelRoomsCollection else {
                throw ServiceError.invalidData(self.entityName)
            }
            let roomReference = collection.document(roomId)
            try roomReference.setData(from: entity, merge: true)
        }
    }
    
    func delete(_ id: String) async throws {
        try await performServiceCall(entity: entityName) {
            guard let collection = self.hotelRoomsCollection else {
                throw ServiceError.userNotAuthenticated
            }
            try await collection.document(id).delete()
        }
    }
}

extension RoomService {
    func getRooms() async throws -> [Room] {
        guard let collection = hotelRoomsCollection else {
            throw RoomError.userNotAuthenticated
        }
        
        do {
            let snapshot = try await collection.getDocuments()
            return try snapshot.documents.compactMap { document in
                try document.data(as: Room.self)
            }
        } catch {
            throw RoomError.failedToFetchRooms
        }
    }
    
    func updateRoom(_ room: Room) async throws {
        guard let roomId = room.id, let collection = hotelRoomsCollection else {
            throw RoomError.invalidRoomData
        }
        
        do {
            let roomReference = collection.document(roomId)
            try roomReference.setData(from: room, merge: true)
        } catch {
            throw RoomError.failedToUpdateRoom
        }
    }
    
    func deleteRoom(_ roomId: String) async throws {
        guard let collection = hotelRoomsCollection else {
            throw RoomError.userNotAuthenticated
        }
        
        do {
            try await collection.document(roomId).delete()
        } catch {
            throw RoomError.failedToDeleteRoom
        }
    }
}

private extension RoomService {
    /// Provides access to the Firestore collection of rooms for the currently authenticated hotel.
    ///
    /// This computed property returns a `CollectionReference` for the hotel's rooms if a user is
    /// authenticated, or `nil` if no user is currently logged in.
    ///
    /// - Returns: A `CollectionReference` pointing to the hotel's bookings collection if authenticated, otherwise `nil`.
    var hotelRoomsCollection: CollectionReference? {
        guard let hotelId = authService.getCurrentUserId() else { return nil }
        return db.collection(FirestoreCollection.hotels.rawValue)
            .document(hotelId)
            .collection(FirestoreCollection.Hotel.rooms.rawValue)
    }
}
