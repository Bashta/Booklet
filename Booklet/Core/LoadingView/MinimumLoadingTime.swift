//
//  MinimumLoadingTime.swift
//  Booklet
//
//  Created by Erison Veshi on 19.7.24.
//

import SwiftUI

@Observable
class MinimumLoadingTime {
    
    // MARK: - Properties
    
    var isLoading = false
    
    private var task: Task<Void, Never>?
    private let minimumLoadingTime: TimeInterval
    
    // MARK: - Lifecycle

    init(minimumLoadingTime: TimeInterval = 1) {
        self.minimumLoadingTime = minimumLoadingTime
    }
}

extension MinimumLoadingTime {

    // MARK: - Public interface

    func start() {
        isLoading = true
        task?.cancel()
        
        task = Task { @MainActor [weak self] in
            guard let self = self else { return }
            try? await Task.sleep(for: .seconds(self.minimumLoadingTime))
            if !Task.isCancelled {
                self.isLoading = false
            }
        }
    }
    
    func stop() {
        task?.cancel()
        task = Task { @MainActor [weak self] in
            guard let self = self else { return }
            if self.isLoading == true {
                let remainingTime = max(0, (self.minimumLoadingTime) - Date().timeIntervalSinceNow)
                try? await Task.sleep(for: .seconds(remainingTime))
            }
            if !Task.isCancelled {
                self.isLoading = false
            }
        }
    }
}
