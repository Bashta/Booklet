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
    
    // MARK: - View
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(bookingViewModel.bookings) { booking in
                    BookingCardView(booking: booking)
                }
            }
            .padding()
        }
        .overlay {
            if bookingViewModel.isLoading {
                ProgressView()
            }
        }
        .alert(isPresented: .init(get: { bookingViewModel.errorMessage != nil }, set: { _ in bookingViewModel.errorMessage = nil })) {
            Alert(title: Text("booking.error"), message: Text(bookingViewModel.errorMessage ?? ""))
        }
        .task {
            await bookingViewModel.fetchBookings()
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("booking.createRandom") {
                    Task {
                        await bookingViewModel.createRandomBookings()
                    }
                }
                .disabled(bookingViewModel.isLoading)
            }
        }
    }
}

#Preview {
    BookingView()
}
