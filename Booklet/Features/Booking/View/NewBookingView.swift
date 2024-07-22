//
//  NewBookingView.swift
//  Booklet
//
//  Created by Erison Veshi on 22.7.24.
//

import SwiftUI

struct NewBookingView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.serviceLocator.bookingViewModel) private var bookingViewModel
    @State private var newBooking = Booking.empty
    
    var body: some View {
        NavigationStack {
            Form {
                Section("booking.form.details") {
                    TextField("booking.form.roomId", text: $newBooking.roomId)
                    DatePicker("booking.form.checkInDate", selection: $newBooking.checkInDate, displayedComponents: .date)
                    DatePicker("booking.form.checkOutDate", selection: $newBooking.checkOutDate, displayedComponents: .date)
                    Stepper("booking.form.guestCount \(newBooking.numberOfGuests)", value: $newBooking.numberOfGuests, in: 1...10)
                }
                
                Section("booking.form.customer") {
                    TextField("booking.form.customerId", text: $newBooking.customerId)
                }
                
                Section("booking.form.payment") {
                    TextField("booking.form.totalPrice", value: $newBooking.totalPrice, format: .currency(code: "USD"))
                }
                
                Section("booking.form.status") {
                    Picker("booking.form.status", selection: $newBooking.status) {
                        ForEach(BookingStatus.allCases, id: \.self) { status in
                            Text("booking.status.\(status.rawValue)").tag(status)
                        }
                    }
                }
                
                Section("booking.form.specialRequests") {
                    TextEditor(text: Binding($newBooking.specialRequests, replacingNilWith: ""))
                }
            }
            .navigationTitle("booking.form.title")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("common.cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("common.save") {
                        Task {
                            await bookingViewModel.addBooking(newBooking)
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NewBookingView()
}
