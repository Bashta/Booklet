//
//  RoomService.swift
//  Booklet
//
//  Created by Erison Veshi on 22.7.24.
//

import Foundation
import FirebaseFirestore

class RoomService: CRUDServiceProtocol {
  
    typealias Entity = Room
    
    let db: Firestore
    let authService: AuthServiceProtocol
    let collectionType: FirestoreCollection.Hotel = .rooms
    let entityName: String = "Room"
    
    init(db: Firestore = Firestore.firestore(), authService: AuthServiceProtocol = AuthService()) {
        self.db = db
        self.authService = authService
    }    
}
