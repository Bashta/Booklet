//
//  AuthView.swift
//  Booklet
//
//  Created by Erison Veshi on 12.7.24.
//

import SwiftUI

struct AuthView: View {
    
    // MARK: - ViewModel
    
    @Environment(\.serviceLocator.authViewModel) private var authViewModel

    // MARK: - Computed properties
    
    private var shouldDisableAuthButton: Bool {
        authViewModel.email.isEmpty || authViewModel.password.isEmpty
    }
    
    var body: some View {
        content
        .padding()
        .frame(width: 300)
    }
}

// MARK: - Content

private extension AuthView {
    var content: some View {
        @Bindable var authViewModel = authViewModel
        
        return VStack(spacing: 20) {
            Image(systemName: "building.2.crop.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.accentColor)
            
            Text("auth.welcome")
                .font(.title)
                .fontWeight(.bold)
            
            TextField("auth.email", text: $authViewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textContentType(.emailAddress)
                .disableAutocorrection(true)
            
            SecureField("auth.password", text: $authViewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textContentType(.password)
            
            if authViewModel.isSignUp {
                PasswordStrengthView(password: authViewModel.password)
            }

            if authViewModel.showError {
                Text(authViewModel.errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            AuthButton(
                title: authViewModel.isSignUp ? "auth.signUp" : "auth.signIn",
                isLoading: authViewModel.isLoading
            ) {
                Task { await authViewModel.performAuth() }
            }
            .disabled(shouldDisableAuthButton)
            
            Button(action: { authViewModel.isSignUp.toggle() }) {
                Text(authViewModel.isSignUp ? "auth.haveAccount" : "auth.noAccount")
            }
            .buttonStyle(.plain)
            
            if authViewModel.showError {
                Text(authViewModel.errorMessage)
                    .foregroundColor(.red)
            }
        }
        .alert("auth.errorTitle", isPresented: $authViewModel.showError) {
            Button("common.ok") {
                authViewModel.showError = false
            }
        } message: {
            Text(authViewModel.errorMessage)
        }
    }
}

#Preview {
    AuthView()
}
