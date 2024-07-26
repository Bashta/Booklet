//
//  SpreadsheetView.swift
//  Booklet
//
//  Created by Erison Veshi on 27.7.24.
//

import SwiftUI

struct SpreadsheetView<
    ColumnView: View,
    RowView: View,
    ContentView: View,
    Column: Hashable,
    Row: Hashable
>: View {
    let columns: [Column]
    let rows: [Row]
    let columnWidth: CGFloat
    let columnHeight: CGFloat
    let rowWidth: CGFloat
    let rowHeight: CGFloat
    let columnView: (Column) -> ColumnView
    let rowView: (Row) -> RowView
    let contentView: (Column, Row) -> ContentView
    
    @State private var scrollOffset: CGPoint = .zero
    
    private var columnCount: Int { columns.count }
    private var rowCount: Int { rows.count }
    
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
    
    private var contentSize: CGSize {
        .init(
            width: (columnWidth * CGFloat(columnCount)) + rowWidth,
            height: (rowHeight * CGFloat(rowCount)) + columnHeight
        )
    }
    
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
