//
//  MainViewViewModel.swift
//  Booklet
//
//  Created by Erison Veshi on 12.7.24.
//

import Foundation

@Observable
class MainViewViewModel {
    
    // MARK: - Properties
    
    private let authService: AuthServiceProtocol
    
    var selectedTab: Tabs = .home
    var isAuthenticated = false
    var isLoading = false
    private var authStateHandler: Any?
    
    // MARK: - Lifecycle
    
    init(authService: AuthServiceProtocol = AuthService()) {
        self.authService = authService
        setupAuthStateListener()
    }
    
    deinit {
        removeAuthStateListener()
    }

    // MARK: - Public interface

    @MainActor
        func signOut() async {
            isLoading = true
            do {
                try await authService.signOut()
                isAuthenticated = false
            } catch {
                print("Error signing out: \(error.localizedDescription)")
            }
            isLoading = false
        }
}

// MARK: - Helpers

private extension MainViewViewModel {
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
}
