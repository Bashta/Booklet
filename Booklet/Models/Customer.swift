//
//  Customer.swift
//  Booklet
//
//  Created by Erison Veshi on 10.7.24.
//

import Foundation

struct Customer: Identifiable, Codable, Hashable {
    static func == (lhs: Customer, rhs: Customer) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: UUID
    var firstName: String
    var lastName: String
    var email: String?
    var phoneNumber: String?
    var address: Address?
    var dateOfBirth: Date?
    var nationality: String?
    var passportNumber: String?
    
    init(
        id: UUID = UUID(),
        firstName: String,
        lastName: String,
        email: String? = nil,
        phoneNumber: String? = nil,
        address: Address? = nil,
        dateOfBirth: Date? = nil,
        nationality: String? = nil,
        passportNumber: String? = nil
    ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.address = address
        self.dateOfBirth = dateOfBirth
        self.nationality = nationality
        self.passportNumber = passportNumber
    }
}

struct Address: Codable, Hashable {
    var street: String?
    var city: String?
    var state: String?
    var postalCode: String?
    var country: String?
}
