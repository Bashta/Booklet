//
//  RoomService.swift
//  Booklet
//
//  Created by Erison Veshi on 22.7.24.
//

import Foundation
import FirebaseFirestore

class RoomService: FirestoreCollectionProvider {
    
    // MARK: - Properties
    
    internal let db: Firestore
    internal let authService: AuthServiceProtocol
    
    private let entityName: String = "Room"
    
    // MARK: - Lifecycle

    init(
        db: Firestore = Firestore.firestore(),
        authService: AuthServiceProtocol = AuthService()
    ) {
        self.db = db
        self.authService = authService
    }
}

// MARK: - CRUD

extension RoomService: CRUDServiceProtocol {

    typealias Entity = Room

    private var hotelRoomsCollection: CollectionReference? {
        return getCollection(for: .rooms)
    }
    
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
