//
//  CustomerService.swift
//  Booklet
//
//  Created by Erison Veshi on 15.7.24.
//

import Foundation
import FirebaseFirestore

protocol CustomerServiceProtocol {
    func createCustomer(_ customer: Customer) async throws
    func getCustomers() async throws -> [Customer]
}

class CustomerService: CustomerServiceProtocol {
    private let db = Firestore.firestore()
    private let authService: AuthServiceProtocol
    
    init(authService: AuthServiceProtocol = AuthService()) {
        self.authService = authService
    }
    
    private var userCustomersCollection: CollectionReference? {
        guard let userId = authService.getCurrentUser()?.id else { return nil }
        return db.collection("users").document(userId).collection("customers")
    }
    
    func createCustomer(_ customer: Customer) async throws {
        guard let collection = userCustomersCollection else {
            throw NSError(domain: "CustomerService", code: 1, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"])
        }
        
        let documentReference = collection.document(customer.uuid.uuidString)
        try documentReference.setData(from: customer)
    }
    
    func getCustomers() async throws -> [Customer] {
        guard let collection = userCustomersCollection else {
            throw NSError(domain: "CustomerService", code: 1, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"])
        }
        
        let snapshot = try await collection.getDocuments()
        return try snapshot.documents.compactMap { try $0.data(as: Customer.self) }
    }
}
