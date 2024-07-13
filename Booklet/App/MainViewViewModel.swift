//
//  MainViewViewModel.swift
//  Booklet
//
//  Created by Erison Veshi on 12.7.24.
//

import Foundation

@Observable
class MainViewViewModel {
    private let authService: AuthServiceProtocol
    var selectedTab: Tabs = .home
    var isAuthenticated = false
    private var authStateHandler: Any?
    
    init(authService: AuthServiceProtocol = AuthService()) {
        self.authService = authService
        setupAuthStateListener()
    }
    
    deinit {
        removeAuthStateListener()
    }
    
    private func setupAuthStateListener() {
        authStateHandler = authService.addStateDidChangeListener { user in
            Task { @MainActor in
                self.isAuthenticated = user != nil
            }
        }
    }
    
    private func removeAuthStateListener() {
        if let handler = authStateHandler {
            authService.removeStateDidChangeListener(handler)
        }
    }
    
    @MainActor
    func signOut() async {
        do {
            try await authService.signOut()
            isAuthenticated = false
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
