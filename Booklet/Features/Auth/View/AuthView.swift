//
//  AuthView.swift
//  Booklet
//
//  Created by Erison Veshi on 12.7.24.
//

import SwiftUI

struct AuthView: View {
    
    @Bindable private var viewModel = AuthViewViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "building.2.crop.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.accentColor)
            
            Text("auth.welcome")
                .font(.title)
                .fontWeight(.bold)
            
            TextField("auth.email", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textContentType(.emailAddress)
                .disableAutocorrection(true)
            
            SecureField("auth.password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textContentType(.password)
            
            if viewModel.isSignUp {
                PasswordStrengthView(password: viewModel.password)
            }

            if viewModel.showError {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            AuthButton(
                title: viewModel.isSignUp ? "auth.signUp" : "auth.signIn",
                isLoading: viewModel.isLoading
            ) {
                Task { await viewModel.performAuth() }
            }
            .disabled(viewModel.email.isEmpty || viewModel.password.isEmpty)
            
            Button(action: { viewModel.isSignUp.toggle() }) {
                Text(viewModel.isSignUp ? "auth.haveAccount" : "auth.noAccount")
            }
            .buttonStyle(.plain)
            
            if viewModel.showError {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
            }
        }
        .padding()
        .frame(width: 300)
        .alert("auth.errorTitle", isPresented: $viewModel.showError) {
            Button("common.ok") {
                viewModel.showError = false
            }
        } message: {
            Text(viewModel.errorMessage)
        }
    }
}

#Preview {
    AuthView()
}
