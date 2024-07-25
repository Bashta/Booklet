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
    
    // MARK: - Lifecycle
    
    init(authService: AuthServiceProtocol = AuthService()) {
        self.authService = authService
    }
    
    // MARK: - Public interface
    
    func createCustomer(_ customer: Customer) async throws {
        guard let collection = hotelCustomersCollection else {
            throw CustomerError.userNotAuthenticated
        }
        
        do {
            let documentReference = collection.document(customer.uuid.uuidString)
            try documentReference.setData(from: customer)
        } catch {
            throw CustomerError.failedToCreateCustomer
        }
    }
    
    func getCustomers() async throws -> [Customer] {
        guard let collection = hotelCustomersCollection else {
            throw CustomerError.userNotAuthenticated
        }
        
        do {
            let snapshot = try await collection.getDocuments()
            return try snapshot.decode(as: Customer.self)
        } catch {
            throw CustomerError.failedToFetchCustomers
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
