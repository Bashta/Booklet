//
//  BookingError.swift
//  Booklet
//
//  Created by Erison Veshi on 20.7.24.
//

import Foundation

enum BookingError: LocalizedError {
    case userNotAuthenticated
    case failedToCreateBooking
    case failedToFetchBookings
    case failedToUpdateBooking
    case failedToDeleteBooking
    case invalidBookingData

    var errorDescription: String? {
        switch self {
        case .userNotAuthenticated:
            return NSLocalizedString("booking.error.userNotAuthenticated", comment: "User is not authenticated")
        case .failedToCreateBooking:
            return NSLocalizedString("booking.error.failedToCreateBooking", comment: "Failed to create booking")
        case .failedToFetchBookings:
            return NSLocalizedString("booking.error.failedToFetchBookings", comment: "Failed to fetch bookings")
        case .failedToUpdateBooking:
            return NSLocalizedString("booking.error.failedToUpdateBooking", comment: "Failed to update booking")
        case .failedToDeleteBooking:
            return NSLocalizedString("booking.error.failedToDeleteBooking", comment: "Failed to delete booking")
        case .invalidBookingData:
            return NSLocalizedString("booking.error.invalidBookingData", comment: "Invalid booking data")
        }
    }}
