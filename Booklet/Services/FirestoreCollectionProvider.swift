//
//  FirestoreCollectionProvider.swift
//  Booklet
//
//  Created by Erison Veshi on 25.7.24.
//

import Foundation
import Firebase

protocol FirestoreCollectionProvider {
    var db: Firestore { get }
    var authService: AuthServiceProtocol { get }
}

extension FirestoreCollectionProvider {
    func getCollection(for collectionType: FirestoreCollection.Hotel) -> CollectionReference? {
        guard let hotelId = authService.getCurrentUserId() else { return nil }
        return db.collection(FirestoreCollection.hotels.rawValue)
            .document(hotelId)
            .collection(collectionType.rawValue)
    }
}
