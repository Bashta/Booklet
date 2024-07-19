//
//  LoadingView.swift
//  Booklet
//
//  Created by Erison Veshi on 19.7.24.
//

import SwiftUI

struct LoadingView: View {
    
    // MARK: - Properties
    
    let title: String
    let description: String?
    
    // MARK: - State
    
    @State private var isAnimating = false
    
    // MARK: - View
    
    var body: some View {
        content
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.windowBackgroundColor))
    }
}

// MARK: - Content
 
private extension LoadingView {
    var content: some View {
        VStack(spacing: 20) {
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(Color.accentColor, lineWidth: 5)
                .frame(width: 50, height: 50)
                .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: isAnimating)
                .onAppear {
                    isAnimating = true
                }
            
            Text(title)
                .font(.headline)
            
            if let description = description {
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

#Preview {
    LoadingView(title: "Loading...", description: "Deze Nuts")
}
