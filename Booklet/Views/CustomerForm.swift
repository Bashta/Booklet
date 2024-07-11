//
//  CustomerForm.swift
//  Booklet
//
//  Created by Erison Veshi on 10.7.24.
//

import SwiftUI

struct CustomerForm: View {
    @Binding var customer: Customer

    var body: some View {
        Form {
            TextField("First Name", text: $customer.firstName)
            TextField("Last Name", text: $customer.lastName)
            TextField("Email", text: Binding(
                get: { customer.email ?? "" },
                set: { customer.email = $0.isEmpty ? nil : $0 }
            ))
            TextField("Phone Number", text: Binding(
                get: { customer.phoneNumber ?? "" },
                set: { customer.phoneNumber = $0.isEmpty ? nil : $0 }
            ))
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    CustomerForm(customer: .constant(.init(firstName: "Jqualin", lastName: "Aaronvich")))
}
