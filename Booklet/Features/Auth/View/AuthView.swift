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
            
            Text("Welcome to Booklet")
                .font(.title)
                .fontWeight(.bold)
            
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textContentType(.emailAddress)
            
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textContentType(.password)
            
            if viewModel.showError {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            AuthButton(
                title: viewModel.isSignUp ? "Sign Up" : "Sign In",
                isLoading: viewModel.isLoading
            ) {
                Task { await viewModel.performAuth() }
            }
            .disabled(viewModel.email.isEmpty || viewModel.password.isEmpty)
            
            Button(action: { viewModel.isSignUp.toggle() }) {
                Text(viewModel.isSignUp ? "Already have an account? **Sign In**" : "Don't have an account yet? **Sign Up Now**")
            }
            .buttonStyle(.plain)
            
            if viewModel.showError {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
            }
        }
        .padding()
        .frame(width: 300)
        .alert("Authentication Error", isPresented: $viewModel.showError) {
            Button("OK") {
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
