//
//  CustomersViewViewModel.swift
//  Booklet
//
//  Created by Erison Veshi on 15.7.24.
//

import Foundation

@Observable
class CustomersViewViewModel {
    
    // MARK: - Properties
    
    private let customerService: CustomerServiceProtocol
    
    var customers: [Customer] = []
    var selectedCustomer: Customer?
    var newCustomer: Customer = .init(firstName: "Name", lastName: "Surname")
    var isAddingNewCustomer = false
    var isLoading = false
    var errorMessage: String?
    
    // MARK: - Lifecycle
    
    init(customerService: CustomerServiceProtocol = CustomerService()) {
        self.customerService = customerService
    }
}

// MARK: - Public interface

extension CustomersViewViewModel {
    func fetchCustomers() async {
        isLoading = true
        do {
            customers = try await customerService.getCustomers()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func addOrUpdateCustomer(_ customer: Customer) async {
        isLoading = true
        do {
            try await customerService.createCustomer(customer)
            await fetchCustomers()
            isAddingNewCustomer = false
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func addNewCustomer() {
        isAddingNewCustomer = true
        newCustomer = Customer(firstName: "Name", lastName: "Surname")
    }
}
