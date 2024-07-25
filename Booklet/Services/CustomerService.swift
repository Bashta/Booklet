//
//  CustomerService.swift
//  Booklet
//
//  Created by Erison Veshi on 15.7.24.
//

import Foundation
import FirebaseFirestore

class CustomerService {

    // MARK: - Properties
    
    private let db = Firestore.firestore()
    private let authService: AuthServiceProtocol
    private let entityName: String = "Customer"

    // MARK: - Lifecycle
    
    init(authService: AuthServiceProtocol = AuthService()) {
        self.authService = authService
    }
}

extension CustomerService: CRUDServiceProtocol {
    typealias Entity = Customer
    
    func create(_ entity: Customer) async throws {
        try await performServiceCall(entity: entityName) {
            guard let collection = self.hotelCustomersCollection else {
                throw ServiceError.userNotAuthenticated
            }
            let roomReference = collection.document()
            try roomReference.setData(from: entity)
        }
    }
    
    func read() async throws -> [Customer] {
        try await performServiceCall(entity: entityName) {
            guard let collection = self.hotelCustomersCollection else {
                throw ServiceError.userNotAuthenticated
            }
            let snapshot = try await collection.getDocuments()
            return try snapshot.documents.compactMap { try $0.data(as: Customer.self) }
        }
    }
    
    func update(_ entity: Customer) async throws {
        try await performServiceCall(entity: entityName) {
            guard let roomId = entity.id, let collection = self.hotelCustomersCollection else {
                throw ServiceError.invalidData(self.entityName)
            }
            let roomReference = collection.document(roomId)
            try roomReference.setData(from: entity, merge: true)
        }
    }
        
    func delete(_ id: String) async throws {
        try await performServiceCall(entity: entityName) {
            guard let collection = self.hotelCustomersCollection else {
                throw ServiceError.userNotAuthenticated
            }
            try await collection.document(id).delete()
        }
    }
}

// MARK: - Helpers

private extension CustomerService {
    /// Provides access to the Firestore collection of customers for the currently authenticated user.
    ///
    /// This computed property returns a `CollectionReference` for the user's customers if a user is
    /// authenticated, or `nil` if no user is currently logged in.
    ///
    /// - Returns: A `CollectionReference` pointing to the user's customers collection if authenticated, otherwise `nil`.
    private var hotelCustomersCollection: CollectionReference? {
        guard let hotelId = authService.getCurrentUserId() else { return nil }
        return db.collection(FirestoreCollection.hotels.rawValue)
            .document(hotelId)
            .collection(FirestoreCollection.Hotel.customers.rawValue)
    }
}
