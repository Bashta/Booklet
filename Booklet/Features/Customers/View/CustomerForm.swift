//
//  CustomerForm.swift
//  Booklet
//
//  Created by Erison Veshi on 10.7.24.
//

import SwiftUI

struct CustomerForm: View {
    
    // MARK: - ViewModel
    
    @Environment(\.serviceLocator.customersViewModel) private var customersViewModel
    
    var body: some View {
        content
        .padding()
        .frame(minWidth: 300, maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Content

private extension CustomerForm {
    var content: some View {
        @Bindable var customersViewModel = customersViewModel
        return Form {
            TextField("customers.firstName", text: $customersViewModel.newCustomer.firstName)
            TextField("customers.lastName", text: $customersViewModel.newCustomer.lastName)
            TextField("customers.nationality", text: Binding($customersViewModel.newCustomer.nationality, replacingNilWith: ""))
            Divider()
            
            Button("customers.save") {
                Task {
                    await customersViewModel.addOrUpdateCustomer(customersViewModel.newCustomer)
                }
            }
            .frame(maxWidth: .infinity)
            .buttonStyle(.borderedProminent)
            .padding(12)
            .disabled(customersViewModel.isLoading)
        }
    }
}

#Preview {
    CustomerForm()
}
