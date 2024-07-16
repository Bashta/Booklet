//
//  CustomersView.swift
//  Booklet
//
//  Created by Erison Veshi on 10.7.24.
//

import SwiftUI

struct CustomersView: View {
    
    // MARK: - State
    
    @State private var viewModel = CustomersViewViewModel()
    
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
                await viewModel.fetchCustomers()
            }
    }
}

// MARK: - Helpers

private extension CustomersView {
    var shouldShowContentUnavailableOverlay: Bool {
        viewModel.customers.isEmpty && !viewModel.isAddingNewCustomer
    }
}

// MARK: - Views

private extension CustomersView {
    var content: some View {
        Group {
            HSplitView {
                List(viewModel.customers, id: \.uuid, selection: $viewModel.selectedCustomer) { customer in
                    Text("\(customer.firstName) \(customer.lastName)")
                }
                .frame(minWidth: 200, maxWidth: .infinity, maxHeight: .infinity)
                
                if viewModel.isAddingNewCustomer {
                    CustomerForm(
                        customer: Binding(
                            $viewModel.selectedCustomer,
                            replacingNilWith: Customer.init(firstName: "", lastName: "")
                        )
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
    }

    var newCustomerToolbarButton: some View {
        Button(action: viewModel.addNewCustomer) {
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
                    viewModel.addNewCustomer()
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
