//
//  AuthViewModel.swift
//  Booklet
//
//  Created by Erison Veshi on 12.7.24.
//

import Foundation

@Observable
class AuthViewViewModel {
    
    // MARK: - Properties
    
    private let authService: AuthServiceProtocol
    
    var email = ""
    var password = ""
    var isSignUp = false
    var showError = false
    var errorMessage = ""
    var isLoading = false
    
    // MARK: - Lifecycle
    
    init(authService: AuthServiceProtocol = AuthService()) {
        self.authService = authService
    }
    
    // MARK: - Public Interface
    
    func performAuth() async {
        guard isValidInput() else { return }
        
        isLoading = true
        do {
            let user = try await (isSignUp ? signUp() : signIn())
            await handleAuthResult(user)
        } catch {
            await handleAuthError(error)
        }
        isLoading = false
    }
}

// MARK: - Helpers

private extension AuthViewViewModel {
    func isValidInput() -> Bool {
        guard !email.isEmpty else {
            showError(message: String(localized: "auth.error.emptyEmail"))
            return false
        }
        guard !password.isEmpty else {
            showError(message: String(localized: "auth.error.emptyPassword"))
            return false
        }
        return true
    }
    
    func signUp() async throws -> AppUser {
        return try await authService.signUp(email: email, password: password)
    }
    
    func signIn() async throws -> AppUser {
        return try await authService.signIn(email: email, password: password)
    }
    
    @MainActor
    func handleAuthResult(_ user: AppUser) {
        showError = false
        errorMessage = ""
        // Handle successful authentication (e.g., navigate to main view)
    }
    
    @MainActor
    func handleAuthError(_ error: Error) {
        showError = true
        if let authError = error as? AuthError {
            errorMessage = authError.localizedDescription
        } else {
            errorMessage = "An unexpected error occurred. Please try again."
        }
    }
    
    func showError(message: String) {
        showError = true
        errorMessage = message
    }
}
