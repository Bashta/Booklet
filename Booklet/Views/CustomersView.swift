//
//  CustomersView.swift
//  Booklet
//
//  Created by Erison Veshi on 10.7.24.
//

import SwiftUI

struct CustomersView: View {
    @State private var customers: [Customer] = []
    @State private var selectedCustomer: Customer?
    @State private var isAddingNewCustomer = false
    
    private var shouldShowEmptyStateView: Bool {
        customers.isEmpty && !isAddingNewCustomer
    }
    
    var body: some View {
        Group {
            if shouldShowEmptyStateView {
                EmptyStateView(
                    title: "No Customers Yet",
                    message: "Start by adding your first customer. Click the button below to get started.",
                    buttonTitle: "Add Customer"
                ) {
                    addCustomer()
                }
            } else {
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
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: addCustomer) {
                    Label("Add Customer", systemImage: "plus")
                }
            }
        }
    }

    private func addCustomer() {
        isAddingNewCustomer = true
        selectedCustomer = nil
    }

    private func binding(for customer: Customer) -> Binding<Customer> {
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

struct EmptyStateView: View {
    var title: String
    var message: String
    var buttonTitle: String
    var action: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.3")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.secondary)

            Text(title)
                .font(.title)
                .fontWeight(.bold)

            Text(message)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button(action: action) {
                Text(buttonTitle)
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(NSColor.windowBackgroundColor))
    }
}

#Preview {
    CustomersView()
}
