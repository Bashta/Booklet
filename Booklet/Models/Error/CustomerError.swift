//
//  CustomerError.swift
//  Booklet
//
//  Created by Erison Veshi on 19.7.24.
//

import Foundation

enum CustomerError: LocalizedError {
    case userNotAuthenticated
    case failedToCreateCustomer
    case failedToFetchCustomers
    case invalidCustomerData
    case networkError
    case unknownError(String)

    var errorDescription: String? {
        switch self {
        case .userNotAuthenticated:
            return NSLocalizedString("customer.error.userNotAuthenticated", comment: "User is not authenticated")
        case .failedToCreateCustomer:
            return NSLocalizedString("customer.error.failedToCreateCustomer", comment: "Failed to create customer")
        case .failedToFetchCustomers:
            return NSLocalizedString("customer.error.failedToFetchCustomers", comment: "Failed to fetch customers")
        case .invalidCustomerData:
            return NSLocalizedString("customer.error.invalidCustomerData", comment: "Invalid customer data")
        case .networkError:
            return NSLocalizedString("customer.error.networkError", comment: "Network error occurred")
        case .unknownError(let message):
            return String(format: NSLocalizedString("customer.error.unknownError", comment: "An unknown error occurred: %@"), message)
        }
    }
}
