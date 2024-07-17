//
//  CustomerForm.swift
//  Booklet
//
//  Created by Erison Veshi on 10.7.24.
//

import SwiftUI

struct CustomerForm: View {
    
    @Environment(\.serviceLocator.customersViewModel) private var customersViewModel

    var body: some View {
        content
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

private extension CustomerForm {
    var content: some View {
        @Bindable var customersViewModel = customersViewModel
        return Form {
            TextField("customers.firstName", text: $customersViewModel.newCustomer.firstName)
            TextField("customers.lastName", text: $customersViewModel.newCustomer.lastName)
            Button("customers.save") {
                print("Save button pressed")
            }
        }
    }
}

#Preview {
    CustomerForm()
}
