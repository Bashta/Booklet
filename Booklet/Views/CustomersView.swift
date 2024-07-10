//
//  CustomersView.swift
//  Booklet
//
//  Created by Erison Veshi on 10.7.24.
//

import SwiftUI

struct CustomersView: View {
    
    // MARK: - State
    
    @State private var customers: [Customer] = []
    @State private var selectedCustomer: Customer?
    @State private var isAddingNewCustomer = false
    
    // MARK: - Computed
    
    private var shouldShowEmptyStateView: Bool {
        customers.isEmpty && !isAddingNewCustomer
    }
    
    var body: some View {
        content
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                newCustomerButton
            }
        }
        .overlay {
            if shouldShowEmptyStateView {
                contentUnavailableView
            }
        }
    }
}

// MARK: - Views

private extension CustomersView {
    var content: some View {
        Group {
            HSplitView {
                // List of customers
                List(customers, selection: $selectedCustomer) { customer in
                    Text("\(customer.firstName) \(customer.lastName)")
                }
                .frame(minWidth: 200)
                
                // Customer form or placeholder
                if let customer = selectedCustomer {
                    CustomerForm(customer: binding(for: customer))
                } else if isAddingNewCustomer {
                    CustomerForm(customer: binding(for: Customer(firstName: "", lastName: "")))
                } else {
                    VStack {
                        Text("Select a customer or add a new one")
                            .font(.headline)
                        Button("Add New Customer") {
                            addCustomer()
                        }
                        .padding()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(NSColor.windowBackgroundColor))
                }
                
            }
        }
    }
    
    var newCustomerButton: some View {
        Button(action: addCustomer) {
            Label("Add Customer", systemImage: "plus")
                .foregroundStyle(Color.accentColor)
        }
    }
    
    var contentUnavailableView: some View {
        ZStack {
            Color(.black)
            ContentUnavailableView {
                Label("No customers yet", systemImage: "person.3")
            } description: {
                Text("Start by adding your first customer. Click the button below to get started.")
            } actions: {
                Button {
                    addCustomer()
                } label: {
                    Image(systemName: "person.fill.badge.plus")
                        .padding(8)
                        .symbolEffect(.breathe)
                        .foregroundStyle(Color.accentColor)
                        .font(.title3)
                }
            }
        }
    }
}

// MARK: - Helpers

private extension CustomersView {
    func addCustomer() {
        isAddingNewCustomer = true
        selectedCustomer = nil
    }
    
    func binding(for customer: Customer) -> Binding<Customer> {
        Binding(
            get: { customer },
            set: { newValue in
                if let index = customers.firstIndex(where: { $0.id == customer.id }) {
                    customers[index] = newValue
                } else {
                    customers.append(newValue)
                }
                isAddingNewCustomer = false
                selectedCustomer = newValue
            }
        )
    }
}

#Preview {
    CustomersView()
}
