//
//  MainView.swift
//  Booklet
//
//  Created by Erison Veshi on 9.7.24.
//

import SwiftUI

struct MainView: View {
    private var title: String { "Booklet" }
    
    var body: some View {

        NavigationSplitView {
            List() {
                ForEach(0..<5) { index in
                    NavigationLink {
                        Text("\(index)")
                    } label: {
                        HStack {
                            Image(systemName: "calendar.badge.clock")
                            Text("Calendar")
                        }
                    }
                    .tag(index)
                }
            }
            .navigationTitle(title)
            .frame(minWidth: 100)
        } detail: {
            Text("Select an option")
        }
    }
}

#Preview {
    MainView()
}
