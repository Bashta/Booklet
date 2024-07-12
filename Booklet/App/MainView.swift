//
//  MainView.swift
//  Booklet
//
//  Created by Erison Veshi on 9.7.24.
//

import SwiftUI

struct MainView: View {
    // MARK: - VM
    
    @Bindable private var viewModel = MainViewViewModel()

    // MARK: - Content
    
    var body: some View {
        Group {
            if viewModel.isAuthenticated {
                content
                    .tabViewStyle(.sidebarAdaptable)
            } else {
                AuthView()
            }
        }
        
    }
}

// MARK: - Views

private extension MainView {
    var content: some View {
        TabView(selection: $viewModel.selectedTab) {
            ForEach(Tabs.allCases) { tab in
                Tab(tab.name, systemImage: tab.symbol, value: tab) {
                    contentForSelectedTab
                }
                .customizationID(tab.customizationID)
            }
        }
    }
    
    var contentForSelectedTab: some View {
        switch viewModel.selectedTab {
        case .calendar: AnyView(CalendarView())
        case .customers: AnyView(CustomersView())
        default: AnyView(Text("Selected \(viewModel.selectedTab.name) Menu item"))
        }
    }
}

#Preview {
    MainView()
}
