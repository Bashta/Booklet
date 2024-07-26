//
//  CustomersViewViewModel.swift
//  Booklet
//
//  Created by Erison Veshi on 15.7.24.
//

import Foundation

@Observable
class CustomersViewViewModel {
    
    private let customerService: CustomerService

    var customers: [Customer] = []
    var selectedCustomer: Customer?
    var newCustomer: Customer = .init(firstName: "Name", lastName: "Surname")
    var isAddingNewCustomer = false
    var isLoading = false
    var errorMessage: String?
    
    init(customerService: CustomerService = CustomerService()) {
        self.customerService = customerService
    }
}

// MARK: - State mangment

extension CustomersViewViewModel {
    func createNewCustomer() {
        isAddingNewCustomer = true
        newCustomer = Customer(firstName: "Name", lastName: "Surname")
    }
}

// MARK: - Public interface

extension CustomersViewViewModel {
    func fetchCustomers() async {
        isLoading = true
        do {
            customers = try await customerService.read()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func addCustomer(_ customer: Customer) async {
        isLoading = true
        do {
            try await customerService.create(customer)
            await fetchCustomers()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func updateCustomer(_ customer: Customer) async {
        isLoading = true
        do {
            try await customerService.update(customer)
            await fetchCustomers()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func deleteCustomer(withId id: String) async {
        isLoading = true
        do {
            try await customerService.delete(id)
            await fetchCustomers()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
