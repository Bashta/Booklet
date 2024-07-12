//
//  AuthViewModel.swift
//  Booklet
//
//  Created by Erison Veshi on 12.7.24.
//


import SwiftUI
import FirebaseAuth

@Observable
class AuthViewViewModel {
    var email = ""
    var password = ""
    var isSignUp = false
    var showError = false
    var errorMessage = ""
    
    func performAuth() {
        if isSignUp {
            signUp()
        } else {
            signIn()
        }
    }
    
    private func signUp() {
        Task {
            do {
                let result = try await Auth.auth().createUser(withEmail: email, password: password)
                await handleAuthResult(result, nil)
            } catch {
                await handleAuthResult(nil, error)
            }
        }
    }
    
    private func signIn() {
        Task {
            do {
                let result = try await Auth.auth().signIn(withEmail: email, password: password)
                await handleAuthResult(result, nil)
            } catch {
                await handleAuthResult(nil, error)
            }
        }
    }
    
    @MainActor
    private func handleAuthResult(_ result: AuthDataResult?, _ error: Error?) {
        if let error = error {
            showError = true
            errorMessage = error.localizedDescription
        } else {
            showError = false
            errorMessage = ""
        }
    }
}
