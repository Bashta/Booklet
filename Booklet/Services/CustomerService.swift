//
//  CustomerService.swift
//  Booklet
//
//  Created by Erison Veshi on 15.7.24.
//

import Foundation
import FirebaseFirestore

class CustomerService: CRUDServiceProtocol {

    typealias Entity = Customer
    
    let db: Firestore
    let authService: AuthServiceProtocol
    let collectionType: FirestoreCollection.Hotel = .customers
    let entityName: String = "Customer"
    
    init(db: Firestore = Firestore.firestore(), authService: AuthServiceProtocol = AuthService()) {
        self.db = db
        self.authService = authService
    }
}
