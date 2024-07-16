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
            TextField("customers.firstName", text: $customer.firstName)
            TextField("customers.lastName", text: $customer.lastName)
            TextField("customers.email", text: Binding($customer.email, replacingNilWith: ""))
            TextField("customers.phoneNumber", text: Binding($customer.phoneNumber, replacingNilWith: ""))
            // FIXME: - When TextField gets focused the customer binding get recreated twice.
            let _ = print(customer)
            Button("customers.save") {
               print("Save button pressed")
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    CustomerForm(customer: .constant(.init(firstName: "Name", lastName: "Surname")))
}
