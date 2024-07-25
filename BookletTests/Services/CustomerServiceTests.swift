//
//  CustomerServiceTests.swift
//  BookletTests
//
//  Created by Erison Veshi on 21.7.24.
//

import XCTest
@testable import Booklet

class CustomerServiceTests: XCTestCase {

    var customerViewModel: CustomersViewViewModel!
    var mockCustomerService: CustomerServiceMock!
    var mockAuthService: AuthServiceMock!

    override func setUp() {
        super.setUp()
        mockCustomerService = CustomerServiceMock()
        mockAuthService = AuthServiceMock()
        customerViewModel = CustomersViewViewModel(customerService: mockCustomerService)
    }

    override func tearDown() {
        customerViewModel = nil
        mockCustomerService = nil
        mockAuthService = nil
        super.tearDown()
    }

    func testFetchCustomersSuccess() async {
        // Arrange
        let mockCustomers = [
            Customer(firstName: "John", lastName: "Doe"),
            Customer(firstName: "Jane", lastName: "Smith")
        ]
        mockCustomerService.mockCustomers = mockCustomers

        // Act
        await customerViewModel.fetchCustomers()

        // Assert
        XCTAssertEqual(customerViewModel.customers.count, mockCustomers.count)
        XCTAssertEqual(customerViewModel.customers[0].firstName, mockCustomers[0].firstName)
        XCTAssertEqual(customerViewModel.customers[1].firstName, mockCustomers[1].firstName)
        XCTAssertFalse(customerViewModel.isLoading)
        XCTAssertNil(customerViewModel.errorMessage)
    }

    func testFetchCustomersFailure() async {
        // Arrange
        mockCustomerService.shouldThrowError = true

        // Act
        await customerViewModel.fetchCustomers()

        // Assert
        XCTAssertTrue(customerViewModel.customers.isEmpty)
        XCTAssertFalse(customerViewModel.isLoading)
        XCTAssertNotNil(customerViewModel.errorMessage)
    }

    func testAddOrUpdateCustomerSuccess() async {
        // Arrange
        let customer = Customer(firstName: "New", lastName: "Customer")

        // Act
        await customerViewModel.addOrUpdateCustomer(customer)

        // Assert
        XCTAssertTrue(mockCustomerService.createCustomerCalled)
        XCTAssertEqual(mockCustomerService.lastCreatedCustomer?.firstName, customer.firstName)
        XCTAssertFalse(customerViewModel.isLoading)
        XCTAssertFalse(customerViewModel.isAddingNewCustomer)
        XCTAssertNil(customerViewModel.errorMessage)
    }

    func testAddOrUpdateCustomerFailure() async {
        // Arrange
        let customer = Customer(firstName: "New", lastName: "Customer")
        mockCustomerService.shouldThrowError = true

        // Act
        await customerViewModel.addOrUpdateCustomer(customer)

        // Assert
        XCTAssertTrue(mockCustomerService.createCustomerCalled)
        XCTAssertFalse(customerViewModel.isLoading)
        XCTAssertNotNil(customerViewModel.errorMessage)
    }

    func testAddNewCustomer() {
        // Act
        customerViewModel.createNewCustomer()

        // Assert
        XCTAssertTrue(customerViewModel.isAddingNewCustomer)
        XCTAssertEqual(customerViewModel.newCustomer.firstName, "Name")
        XCTAssertEqual(customerViewModel.newCustomer.lastName, "Surname")
    }
}
