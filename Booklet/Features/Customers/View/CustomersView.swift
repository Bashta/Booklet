//
//  CustomersView.swift
//  Booklet
//
//  Created by Erison Veshi on 10.7.24.
//

import SwiftUI

struct CustomersView: View {
    
    // MARK: - ViewModel
    
    @Environment(\.serviceLocator.customersViewModel) private var customersViewModel

    // MARK: - View
    
    var body: some View {
        content
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    newCustomerToolbarButton
                }
            }
            .overlay {
                if shouldShowContentUnavailableOverlay {
                    contentUnavailableView
                }
            }
            .task {
                await customersViewModel.fetchCustomers()
            }
    }
}

// MARK: - Helpers

private extension CustomersView {
    var shouldShowContentUnavailableOverlay: Bool {
        customersViewModel.customers.isEmpty && !customersViewModel.isAddingNewCustomer
    }
}

// MARK: - Content

private extension CustomersView {
    var content: some View {
        @Bindable var customersViewModel = customersViewModel
        
        return Group {
            HSplitView {
                List(customersViewModel.customers, id: \.uuid, selection: $customersViewModel.selectedCustomer) { customer in
                    Text("\(customer.firstName) \(customer.lastName)")
                }
                .frame(minWidth: 200, maxWidth: .infinity, maxHeight: .infinity)
                
                if customersViewModel.isAddingNewCustomer {
                    CustomerForm()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
    }

    var newCustomerToolbarButton: some View {
        Button(action: customersViewModel.addNewCustomer) {
            Label("customers.addCustomer.button", systemImage: "plus")
                .foregroundStyle(Color.accentColor)
        }
    }

    var contentUnavailableView: some View {
        ZStack {
            Color(.black)
            ContentUnavailableView {
                Label("customers.noCustomers", systemImage: "person.3")
            } description: {
                Text("customers.noCustomers.description")
            } actions: {
                Button {
                    customersViewModel.addNewCustomer()
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

#Preview {
    CustomersView()
}
