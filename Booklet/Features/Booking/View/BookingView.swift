//
//  BookingView.swift
//  Booklet
//
//  Created by Erison Veshi on 20.7.24.
//

import SwiftUI

struct BookingView: View {
    
    // MARK: - ViewModel
    
    @Environment(\.serviceLocator.bookingViewModel) private var bookingViewModel
    
    // MARK: - Properties

    @State private var isShowingNewBookingView = false

    // MARK: - View
    
    var body: some View {
            content
            .loading(
                isLoading: bookingViewModel.isLoading,
                title: "bookings.loading.title",
                description: "bookings.loading.title"
            )
            .alert(
                isPresented: .init(
                    get: { bookingViewModel.errorMessage != nil },
                    set: { _ in bookingViewModel.errorMessage = nil })
            ) {
                Alert(title: Text("booking.error"), message: Text(bookingViewModel.errorMessage ?? ""))
            }
            .task {
                await bookingViewModel.fetchBookings()
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    AddEntityButton(
                        title: "booking.addNew",
                        action: { isShowingNewBookingView = true }
                    )
                }
            }
            .sheet(isPresented: $isShowingNewBookingView) {
                NewBookingView()
            }
        }
}

private extension BookingView {
    var content: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(bookingViewModel.bookings) { booking in
                    BookingCardView(booking: booking)
                }
            }
            .padding()
        }
    }
}

#Preview {
    BookingView()
}
