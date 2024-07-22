//
//  RoomService.swift
//  Booklet
//
//  Created by Erison Veshi on 22.7.24.
//

import Foundation
import FirebaseFirestore

// MARK: - Interface

protocol RoomServiceProtocol {
    func createRoom(_ room: Room) async throws
    func getRooms() async throws -> [Room]
    func updateRoom(_ room: Room) async throws
    func deleteRoom(_ roomId: String) async throws
}

class RoomService: RoomServiceProtocol {
    
    // MARK: - Properties
    
    private let db = Firestore.firestore()
    private let authService: AuthServiceProtocol
    
    // MARK: - Lifecycle

    init(authService: AuthServiceProtocol = AuthService()) {
        self.authService = authService
    }
}

extension RoomService {
    func createRoom(_ room: Room) async throws {
        guard let collection = hotelRoomsCollection else {
            throw RoomError.userNotAuthenticated
        }
        
        do {
            let roomReference = collection.document()
            try roomReference.setData(from: room)
        } catch {
            throw RoomError.failedToCreateRoom
        }
    }
    
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
    var hotelRoomsCollection: CollectionReference? {
        guard let hotelId = authService.getCurrentUserId() else { return nil }
        return db.collection(FirestoreCollection.hotels.rawValue)
            .document(hotelId)
            .collection(FirestoreCollection.Hotel.rooms.rawValue)
    }
}
