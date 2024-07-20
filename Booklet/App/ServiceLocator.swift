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
    let bookingViewModel: BookingViewViewModel

    // MARK: - Lifecycle

    init() {
        self.mainViewModel = MainViewViewModel()
        self.customersViewModel = CustomersViewViewModel()
        self.authViewModel = AuthViewViewModel()
        self.bookingViewModel = BookingViewViewModel()
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
