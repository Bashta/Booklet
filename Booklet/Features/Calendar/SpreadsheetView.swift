//
//  SpreadsheetView.swift
//  Booklet
//
//  Created by Erison Veshi on 27.7.24.
//

import SwiftUI

/// A custom view that presents data in a spreadsheet-like grid format.
///
/// `SpreadsheetView` is designed to display a large amount of data in a scrollable grid,
/// similar to a spreadsheet. It's particularly useful for presenting tabular data
/// such as hotel room availability over time.
///
/// The view is highly customizable, allowing for different types of column headers,
/// row headers, and cell contents. It handles both vertical and horizontal scrolling
/// while keeping headers fixed.
///
/// Example usage:
/// ```
/// SpreadsheetView(
///     columns: dateRange,
///     rows: roomNumbers,
///     columnWidth: 100,
///     columnHeight: 30,
///     rowWidth: 100,
///     rowHeight: 30
/// ) { date in
///     Text(formatDate(date))
/// } rowView: { roomNumber in
///     Text(roomNumber)
/// } contentView: { date, roomNumber in
///     // Your cell content here
/// }
/// ```
///
/// - Note: This view uses `ObservableScrollView` internally to handle scrolling,
///   which may affect layout in complex view hierarchies.
struct SpreadsheetView<
    ColumnView: View,
    RowView: View,
    ContentView: View,
    Column: Hashable,
    Row: Hashable
>: View {
    /// The data for column headers.
        let columns: [Column]
        
        /// The data for row headers.
        let rows: [Row]
        
        /// The width of each column.
        let columnWidth: CGFloat
        
        /// The height of the column headers.
        let columnHeight: CGFloat
        
        /// The width of the row headers.
        let rowWidth: CGFloat
        
        /// The height of each row.
        let rowHeight: CGFloat
        
        /// A closure that returns a view for each column header.
        let columnView: (Column) -> ColumnView
        
        /// A closure that returns a view for each row header.
        let rowView: (Row) -> RowView
        
        /// A closure that returns a view for each cell in the grid.
        let contentView: (Column, Row) -> ContentView
        
        /// The current scroll offset of the grid.
        @State private var scrollOffset: CGPoint = .zero
        
        /// The total number of columns in the grid.
        private var columnCount: Int { columns.count }
        
        /// The total number of rows in the grid.
        private var rowCount: Int { rows.count }
        
        /// The body of the `SpreadsheetView`.
        ///
        /// This computed property constructs the entire grid view, including
        /// fixed headers and scrollable content.
    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                leftContentView()
                rightContentView()
            }
            ObservableScrollView(
                axis: [.vertical, .horizontal],
                scrollOffset: $scrollOffset
            ) { _ in
                Color.clear
                    .frame(width: contentSize.width, height: contentSize.height)
            }
            .opacity(0.5)
        }
    }
    
    /// Calculates the total size of the content area.
    private var contentSize: CGSize {
        .init(
            width: (columnWidth * CGFloat(columnCount)) + rowWidth,
            height: (rowHeight * CGFloat(rowCount)) + columnHeight
        )
    }
    
    /// Creates the left side of the grid, containing fixed row headers.
    private func leftContentView() -> some View {
        VStack(spacing: 0) {
            Color.white
                .frame(width: rowWidth, height: columnHeight)
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    ForEach(rows, id: \.self) { row in
                        rowView(row)
                            .frame(width: rowWidth, height: rowHeight)
                    }
                }
                .offset(y: scrollOffset.y)
            }
            .disabled(true)
        }
    }
    
    /// Creates the right side of the grid, containing column headers and scrollable content.
    private func rightContentView() -> some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(columns, id: \.self) { column in
                        columnView(column)
                            .frame(width: columnWidth, height: columnHeight)
                    }
                }
                .offset(x: scrollOffset.x)
            }
            .disabled(true)
            ScrollView([.vertical, .horizontal]) {
                VStack(spacing: 0) {
                    ForEach(rows, id: \.self) { row in
                        HStack(spacing: 0) {
                            ForEach(columns, id: \.self) { column in
                                contentView(column, row)
                                    .frame(width: columnWidth, height: rowHeight)
                            }
                        }
                    }
                }
                .offset(x: scrollOffset.x, y: scrollOffset.y)
            }
        }
    }
}
