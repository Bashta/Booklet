//
//  StatusBadge.swift
//  Booklet
//
//  Created by Erison Veshi on 22.7.24.
//

import SwiftUI

struct StatusBadge: View {
    
    // MARK: - Properties
    
    let status: BookingStatus
    
    // MARK: - View
    
    var body: some View {
        Text("booking.status.\(status.rawValue)")
            .font(.caption)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(backgroundColor)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}

// MARK: - Helpers

private extension StatusBadge {
    var backgroundColor: Color {
        switch status {
        case .pending: return .orange
        case .confirmed: return .green
        case .checkedIn: return .blue
        case .checkedOut: return .gray
        case .cancelled: return .red
        }
    }
}
