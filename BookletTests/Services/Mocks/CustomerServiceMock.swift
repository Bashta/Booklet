//
//  CustomerServiceMock.swift
//  BookletTests
//
//  Created by Erison Veshi on 21.7.24.
//

import Foundation
@testable import Booklet

class CustomerServiceMock: CustomerServiceProtocol {
    var createCustomerCalled = false
    var lastCreatedCustomer: Customer?
    var shouldThrowError = false
    var mockCustomers: [Customer] = []

    func createCustomer(_ customer: Customer) async throws {
        createCustomerCalled = true
        lastCreatedCustomer = customer
        if shouldThrowError {
            throw CustomerError.failedToCreateCustomer
        }
    }

    func getCustomers() async throws -> [Customer] {
        if shouldThrowError {
            throw CustomerError.failedToFetchCustomers
        }
        return mockCustomers
    }
}
