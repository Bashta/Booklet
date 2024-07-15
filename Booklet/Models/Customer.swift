//
//  Customer.swift
//  Booklet
//
//  Created by Erison Veshi on 10.7.24.
//

import Foundation
import FirebaseFirestoreSwift

struct Customer: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    var firstName: String
    var lastName: String
    var email: String?
    var phoneNumber: String?
    var address: Address?
    var dateOfBirth: Date?
    var nationality: String?
    var passportNumber: String?
}

extension Customer {
    static func == (lhs: Customer, rhs: Customer) -> Bool {
        lhs.id == rhs.id
    }
}

struct Address: Codable, Hashable {
    var street: String?
    var city: String?
    var state: String?
    var postalCode: String?
    var country: String?
}
