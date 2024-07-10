//
//  Tabs.swift
//  Booklet
//
//  Created by Erison Veshi on 9.7.24.
//

import Foundation

/// A description of the tabs that the app can present.
enum Tabs: Equatable, Hashable, Identifiable, CaseIterable {
    case home
    case calendar
    case arrival
    case stats
    
    var id: Int {
        switch self {
        case .home: 2001
        case .calendar: 2002
        case .arrival: 2003
        case .stats: 2004
        }
    }
    
    var name: String {
        switch self {
        case .home: String(localized: "Home", comment: "Tab title")
        case .calendar: String(localized: "Calendar", comment: "Tab title")
        case .stats: String(localized: "Stats", comment: "Tab title")
        case .arrival: String(localized: "Arrivals", comment: "Tab title")
        }
    }
    
    var customizationID: String {
        return "com.PrometheusBits.Booklet." + self.name
    }

    var symbol: String {
        switch self {
        case .home: "house.fill"
        case .calendar: "calendar.badge.clock"
        case .stats: "books.vertical"
        case .arrival: "figure.walk.arrival"
        }
    }
}
