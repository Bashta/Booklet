//
//  LoadingViewModifier.swift
//  Booklet
//
//  Created by Erison Veshi on 19.7.24.
//

import SwiftUI

struct LoadingViewModifier: ViewModifier {
    
    // MARK: - State
    
    @State private var minimumLoadingTime = MinimumLoadingTime()

    // MARK: - Properties
    
    let isLoading: Bool
    let title: String
    let description: String?
    
    // MARK: - View
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(minimumLoadingTime.isLoading)
                .blur(radius: minimumLoadingTime.isLoading ? 3 : 0)
            
            if minimumLoadingTime.isLoading {
                LoadingView(title: title, description: description)
            }
        }
        .onChange(of: isLoading) { _, newValue in
            if newValue {
                minimumLoadingTime.start()
            } else {
                minimumLoadingTime.stop()
            }
        }
    }
}

// MARK: - Helper

extension View {
    func loading(isLoading: Bool, title: String, description: String? = nil) -> some View {
        modifier(LoadingViewModifier(isLoading: isLoading, title: title, description: description))
    }
}
