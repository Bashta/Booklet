//
//  FirestoreExtensions.swift
//  Booklet
//
//  Created by Erison Veshi on 19.7.24.
//

import FirebaseFirestore

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
