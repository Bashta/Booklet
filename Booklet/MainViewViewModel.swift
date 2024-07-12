//
//  MainViewViewModel.swift
//  Booklet
//
//  Created by Erison Veshi on 12.7.24.
//

import Foundation
import FirebaseAuth

@Observable
class MainViewViewModel {
    var selectedTab: Tabs = .home
    var isAuthenticated = false
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    
    init() {
        setupAuthStateListener()
    }
    
    deinit {
        removeAuthStateListener()
    }
    
    private func setupAuthStateListener() {
        authStateHandler = Auth.auth().addStateDidChangeListener { (_, user) in
            Task { @MainActor in
                self.isAuthenticated = user != nil
            }
        }
    }
    
    private func removeAuthStateListener() {
        if let handler = authStateHandler {
            Auth.auth().removeStateDidChangeListener(handler)
        }
    }
    
    @MainActor
    func signOut() {
        Task {
            do {
                try Auth.auth().signOut()
                isAuthenticated = false
            } catch {
                print("Error signing out: \(error.localizedDescription)")
            }
        }
    }
}
