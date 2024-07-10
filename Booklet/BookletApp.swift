//
//  BookletApp.swift
//  Booklet
//
//  Created by Erison Veshi on 4.7.24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        FirebaseApp.configure()
    }
}

@main
struct BookletApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .frame(minWidth: Constants.contentWindowWidth, maxWidth: .infinity, minHeight: Constants.contentWindowHeight, maxHeight: .infinity)
        }
        .windowResizability(.contentSize)
    }
}
