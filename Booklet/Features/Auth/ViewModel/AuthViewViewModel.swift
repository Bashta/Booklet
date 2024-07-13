//
//  AuthViewModel.swift
//  Booklet
//
//  Created by Erison Veshi on 12.7.24.
//

import Foundation

@Observable
class AuthViewViewModel {
    private let authService: AuthServiceProtocol
    var email = ""
    var password = ""
    var isSignUp = false
    var showError = false
    var errorMessage = ""
    
    init(authService: AuthServiceProtocol = AuthService()) {
        self.authService = authService
    }
    
    func performAuth() async {
        do {
            let user = try await (isSignUp ? signUp() : signIn())
            await handleAuthResult(user)
        } catch {
            await handleAuthError(error)
        }
    }
    
    private func signUp() async throws -> AppUser {
        return try await authService.signUp(email: email, password: password)
    }
    
    private func signIn() async throws -> AppUser {
        return try await authService.signIn(email: email, password: password)
    }
    
    @MainActor
    private func handleAuthResult(_ user: AppUser) {
        showError = false
        errorMessage = ""
    }
    
    @MainActor
    private func handleAuthError(_ error: Error) {
        showError = true
        errorMessage = error.localizedDescription
    }
}
