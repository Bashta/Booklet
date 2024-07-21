//
//  FirestoreCollection.swift
//  Booklet
//
//  Created by Erison Veshi on 20.7.24.
//

import Foundation

/// `FirestoreCollection` defines the structure of collections in the Firestore database
/// for the Booklet hotel management application.
///
/// This enum provides a type-safe way to reference Firestore collections and
/// sub-collections, preventing the use of hard-coded strings throughout the application.
///
/// The structure represents a multi-tenant architecture where:
/// - Each hotel is a document in the top-level 'hotels' collection.
/// - Each hotel document contains 'customers' and 'bookings' sub-collections.
///
/// Usage example:
/// ```
/// let hotelsCollection = db.collection(FirestoreCollection.hotels.rawValue)
/// let customersCollection = hotelsCollection.document(hotelId)
///     .collection(FirestoreCollection.Hotel.customers.rawValue)
/// ```
///
/// This structure ensures data isolation between different hotels and
/// provides a clear, hierarchical organization of hotel-related data.
enum FirestoreCollection: String {
    /// The top-level collection containing all hotel documents.
    case hotels = "hotels"
    
    /// Represents the sub-collections within each hotel document.
    enum Hotel: String {
        /// The collection of customer documents for a specific hotel.
        case customers = "customers"
        
        /// The collection of booking documents for a specific hotel.
        case bookings = "bookings"
    }
}
