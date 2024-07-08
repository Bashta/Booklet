//
//  BookletApp.swift
//  Booklet
//
//  Created by Erison Veshi on 4.7.24.
//

import SwiftUI

@main
struct BookletApp: App {
    var body: some Scene {
        WindowGroup {
            SpreadsheetViewRepresentable()
                .frame(minWidth: 800, minHeight: 600)
        }
    }
}

struct SpreadsheetViewRepresentable: NSViewRepresentable {
    func makeNSView(context: Context) -> SpreadsheetView {
        return SpreadsheetView(frame: .zero)
    }
    
    func updateNSView(_ nsView: SpreadsheetView, context: Context) {
        // Update the view if needed
    }
}
