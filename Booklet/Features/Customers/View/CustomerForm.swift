//
//  CustomerForm.swift
//  Booklet
//
//  Created by Erison Veshi on 10.7.24.
//

import SwiftUI

struct CustomerForm: View {
    @Binding var customer: Customer
    var onSave: (Customer) async -> Void
    
    var body: some View {
        Form {
            TextField("customers.firstName", text: $customer.firstName)
            TextField("customers.lastName", text: $customer.lastName)
            TextField("customers.email", text: Binding(
                get: { customer.email ?? "" },
                set: { customer.email = $0.isEmpty ? nil : $0 }
            ))
            TextField("customers.phoneNumber", text: Binding(
                get: { customer.phoneNumber ?? "" },
                set: { customer.phoneNumber = $0.isEmpty ? nil : $0 }
            ))
            
            Button("customers.save") {
                Task {
                    await onSave(customer)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    CustomerForm(
        customer: .constant(.init(firstName: "Jqualin", lastName: "Aaronvich")),
        onSave: { _ in
        })
}
