//
//  DateFormatter+Utils.swift
//  Booklet
//
//  Created by Erison Veshi on 31.7.24.
//

import Foundation

extension DateFormatter {
    /// A static DateFormatter instance for formatting dates in the "MMM d" format.
    private static let calendarDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter
    }()

    /// Formats a date into a string representation suitable for calendar display.
    ///
    /// This method uses a shared static DateFormatter to efficiently convert dates
    /// to strings in the format "MMM d" (e.g., "Jul 28").
    ///
    /// - Parameter date: The date to be formatted.
    /// - Returns: A string representation of the date in "MMM d" format.
    static func formatCalendarDate(_ date: Date) -> String {
        return calendarDateFormatter.string(from: date)
    }
}
