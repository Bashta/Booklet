//
//  FirestoreExtensions.swift
//  Booklet
//
//  Created by Erison Veshi on 19.7.24.
//

import FirebaseFirestore

extension CollectionReference {
    /// Creates a reference to a collection of customer documents for a specific user.
    ///
    /// This method constructs a path to a subcollection of customers within a user's document.
    /// It's designed to be used with Firestore's collection-document-collection pattern.
    ///
    /// - Parameter userId: The ID of the user whose customer collection is being accessed.
    /// - Returns: A `CollectionReference` pointing to the user's customers collection.
    static func customersCollection(for userId: String) -> CollectionReference {
        return Firestore.firestore()
            .collection(FirestoreCollection.users.rawValue)
            .document(userId)
            .collection(FirestoreCollection.Users.customers.rawValue)
    }
}

extension QuerySnapshot {
    /// Decodes the documents in the QuerySnapshot to an array of specified Decodable type.
    ///
    /// This method attempts to decode each document in the QuerySnapshot to the specified type.
    /// If any document fails to decode, it throws a CustomerError.invalidCustomerData error.
    ///
    /// - Parameter type: The Decodable type to decode the documents into.
    /// - Throws: CustomerError.invalidCustomerData if any document fails to decode.
    /// - Returns: An array of decoded objects of the specified type.
    func decode<T: Decodable>(as type: T.Type) throws -> [T] {
        try self.documents.compactMap { document in
            do {
                return try document.data(as: type)
            } catch {
                throw CustomerError.invalidCustomerData
            }
        }
    }
}
