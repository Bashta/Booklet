//
//  MainView.swift
//  Booklet
//
//  Created by Erison Veshi on 9.7.24.
//

import SwiftUI

struct MainView: View {
    // MARK: - State

    @State private var selectedTab: Tabs = .home

    // MARK: - Content
    
    var body: some View {
        content
        .tabViewStyle(.sidebarAdaptable)
    }
}

// MARK: - Views

private extension MainView {
    var content: some View {
        TabView(selection: $selectedTab) {
            ForEach(Tabs.allCases) { tab in
                Tab(tab.name, systemImage: tab.symbol, value: tab) {
                    contentForSelectedTab
                }
                .customizationID(tab.customizationID)
            }
        }
    }
    
    var contentForSelectedTab: some View {
        switch selectedTab {
        case .calendar: AnyView(CalendarView())
        case .customers: AnyView(CustomersView())
        default: AnyView(Text("Selected \(selectedTab.name) Menu item"))
        }
    }
}

#Preview {
    MainView()
}