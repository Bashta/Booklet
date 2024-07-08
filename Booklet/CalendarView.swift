//
//  CalendarView.swift
//  Booklet
//
//  Created by Erison Veshi on 4.7.24.
//

import SwiftUI

struct CalendarView: View {
    let rows = CalendarGridItem.mockItems()
    let columns = CalendarGridItem.mockItems()
    
    var body: some View {
        ScrollView() {
            VStack(alignment: .leading) {
                ForEach(rows.indices, id: \.self) { index in
                    Text("Room: \(index + 101)")
                }
            }
        }
        
    }
}

#Preview {
    CalendarView()
}

struct CalendarGridItem {
    let id: UUID = .init()
    let title: String
}
extension CalendarGridItem: Identifiable {}

extension CalendarGridItem {
    static func mockItems(_ numberOfItems: Int = 150) -> [CalendarGridItem] {
        var rows: [CalendarGridItem] = []
        for index in 0..<numberOfItems {
            rows.append(CalendarGridItem(title: "\(index)"))
        }
        return rows
    }
}
