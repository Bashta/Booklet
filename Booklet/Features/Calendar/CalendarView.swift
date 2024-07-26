//
//  CalendarView.swift
//  Booklet
//
//  Created by Erison Veshi on 27.7.24.
//

import SwiftUI

struct CalendarView: View {
    let columns: [Date]
    let rows: [String]
    
    init() {
        columns = CalendarView.generateDates()
        rows = CalendarView.generateRoomNumbers()
    }
    
    var body: some View {
        SpreadsheetView(
            columns: columns,
            rows: rows,
            columnWidth: 100,
            columnHeight: 30,
            rowWidth: 100,
            rowHeight: 30
        ) { column in
            Text(formatDate(column))
                .frame(width: 100, height: 30)
                .background(Color.gray.opacity(0.2))
        } rowView: { row in
            Text(row)
                .frame(width: 100, height: 30)
                .background(Color.gray.opacity(0.2))
        } contentView: { column, row in
            Rectangle()
                .fill(Color.clear)
                .border(Color.gray, width: 0.5)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter.string(from: date)
    }
    
    private static func generateDates() -> [Date] {
        let calendar = Calendar.current
        let today = Date()
        return (0..<30).map { day in
            calendar.date(byAdding: .day, value: day, to: today)!
        }
    }
    
    private static func generateRoomNumbers() -> [String] {
        (1...69).map { "Room \(String(format: "%03d", $0))" }
    }
}

#Preview {
    CalendarView()
}
