//
//  AuthButton.swift
//  Booklet
//
//  Created by Erison Veshi on 13.7.24.
//

import SwiftUI

struct AuthButton: View {
    let title: String
    let isLoading: Bool
    let action: () async -> Void

    var body: some View {
        Button {
            Task { await action() }
        } label: {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .padding(4)
            } else {
                Text(title)
                    .padding(4)
            }
        }
        .frame(maxWidth: .infinity)
        .buttonStyle(.borderedProminent)
        .disabled(isLoading)
        .padding(12)
    }
}

#Preview {
    AuthButton(
        title: "Sign in",
        isLoading: false,
        action: {
        print("Look at my action! My acion is amazing!")
    })
    
    AuthButton(
        title: "Sign in",
        isLoading: true,
        action: {
        print("Look at my action! My acion is amazing!")
    })
}
