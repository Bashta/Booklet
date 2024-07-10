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

    // MARK: - Decorations

    private var title: String { String(localized: "Booklet", comment: "Navigation Bar Title") }

    // MARK: - Content
    
    var body: some View {
        content
        .tabViewStyle(.sidebarAdaptable)
    }
}

extension MainView {
    private var content: some View {
        TabView(selection: $selectedTab) {
            ForEach(Tabs.allCases) { tab in
                Tab(tab.name, systemImage: tab.symbol, value: tab) {
                    contentForSelectedTab
                }
                .customizationID(tab.customizationID)
            }
        }
    }
    
    private var contentForSelectedTab: some View {
        switch selectedTab {
        default: Text("Selected \(selectedTab.name) Menu item")
        }
    }
}

#Preview {
    MainView()
}
