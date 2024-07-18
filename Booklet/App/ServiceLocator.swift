//
//  ServiceLocator.swift
//  Booklet
//
//  Created by Erison Veshi on 17.7.24.
//

import Foundation
import SwiftUI

@Observable
class ServiceLocator {
    
    // MARK: - Dependecies
    
    let mainViewModel: MainViewViewModel
    let customersViewModel: CustomersViewViewModel
    let authViewModel: AuthViewViewModel
    
    // MARK: - Lifecycle

    init() {
        self.mainViewModel = MainViewViewModel()
        self.customersViewModel = CustomersViewViewModel()
        self.authViewModel = AuthViewViewModel()
    }
}

private struct ServiceLocatorKey: EnvironmentKey {
    static let defaultValue = ServiceLocator()
}

extension EnvironmentValues {
    var serviceLocator: ServiceLocator {
        get { self[ServiceLocatorKey.self] }
        set { self[ServiceLocatorKey.self] = newValue }
    }
}
