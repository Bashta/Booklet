//
//  BookingService.swift
//  Booklet
//
//  Created by Erison Veshi on 20.7.24.
//

import Foundation
import FirebaseFirestore


class BookingService: CRUDServiceProtocol {
   
    typealias Entity = Booking
    
    let db: Firestore
    let authService: AuthServiceProtocol
    let collectionType: FirestoreCollection.Hotel = .bookings
    let entityName: String = "Booking"
    
    init(db: Firestore = Firestore.firestore(), authService: AuthServiceProtocol = AuthService()) {
        self.db = db
        self.authService = authService
    }
}
