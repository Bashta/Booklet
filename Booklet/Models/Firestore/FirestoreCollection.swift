//
//  FirestoreCollection.swift
//  Booklet
//
//  Created by Erison Veshi on 20.7.24.
//

import Foundation

enum FirestoreCollection: String {
    case users = "users"
    
    enum Users: String {
        case customers = "customers"
    }
}

enum FirestoreDocument: String {
    case user = "user"
}
