//
//  CustomerService.swift
//  Booklet
//
//  Created by Erison Veshi on 15.7.24.
//

import Foundation
import FirebaseFirestore

class CustomerService: FirestoreCollectionProvider {

    // MARK: - Properties
    
    internal let db: Firestore
    internal let authService: AuthServiceProtocol
    
    private let entityName: String = "Customer"

    // MARK: - Lifecycle
    
    init(
        db: Firestore = Firestore.firestore(),
        authService: AuthServiceProtocol = AuthService()
    ) {
        self.db = db
        self.authService = authService
    }
}

extension CustomerService: CRUDServiceProtocol {
  
    typealias Entity = Customer
    
    private var hotelCustomersCollection: CollectionReference? {
        return getCollection(for: .bookings)
    }
    
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
