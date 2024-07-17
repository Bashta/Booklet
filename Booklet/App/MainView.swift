//
//  MainView.swift
//  Booklet
//
//  Created by Erison Veshi on 9.7.24.
//

import SwiftUI

struct MainView: View {
    
    // MARK: - VM
    
    @Environment(\.serviceLocator.mainViewModel) private var mainViewModel

    // MARK: - Content
    
    var body: some View {
        Group {
            if mainViewModel.isAuthenticated {
                content
                    .tabViewStyle(.sidebarAdaptable)
                    .toolbar { logOutToolbarItem }
            } else {
                AuthView()
            }
        }
        
    }
}

// MARK: - Views

private extension MainView {
    var content: some View {
        @Bindable var mainViewModel = mainViewModel
        return TabView(selection: $mainViewModel.selectedTab) {
            ForEach(Tabs.allCases) { tab in
                Tab(tab.name, systemImage: tab.symbol, value: tab) {
                    contentForSelectedTab
                }
                .customizationID(tab.customizationID)
            }
        }
    }
    
    var contentForSelectedTab: some View {
        switch mainViewModel.selectedTab {
        case .calendar: AnyView(CalendarView())
        case .customers: AnyView(CustomersView())
        default: AnyView(Text("Selected \(mainViewModel.selectedTab.name) Menu item"))
        }
    }
    
    var logOutToolbarItem: ToolbarItem<(), some View> {
        ToolbarItem(placement: .automatic) {
            AuthButton(title: "Log Out",
                       systemImage: "rectangle.portrait.and.arrow.right",
                       isLoading: mainViewModel.isLoading) {
                Task { await mainViewModel.signOut() }
            }
        }
    }
}

#Preview {
    MainView()
}
