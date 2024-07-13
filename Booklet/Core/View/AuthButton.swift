//
//  AuthButton.swift
//  Booklet
//
//  Created by Erison Veshi on 13.7.24.
//

import SwiftUI

struct AuthButton: View {
    private let title: String
    private var systemImage: String? = nil
    private let isLoading: Bool
    private let action: () -> Void
    
    init(title: String, systemImage: String? = nil, isLoading: Bool, action: @escaping () -> Void) {
        self.title = title
        self.systemImage = systemImage
        self.isLoading = isLoading
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .padding(4)
            } else {
                if let systemImage = systemImage {
                    Label(title, systemImage: systemImage)
                } else {
                    Text(title)
                        .padding(4)
                }
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
