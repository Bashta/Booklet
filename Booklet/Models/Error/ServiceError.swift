//
//  ServiceError.swift
//  Booklet
//
//  Created by Erison Veshi on 24.7.24.
//

import Foundation

enum ServiceError: LocalizedError {
    case userNotAuthenticated
    case failedToCreate(String)
    case failedToFetch(String)
    case failedToUpdate(String)
    case failedToDelete(String)
    case invalidData(String)
    case networkError
    case unknownError(String)

    var errorDescription: String? {
        switch self {
        case .userNotAuthenticated:
            return NSLocalizedString("error.userNotAuthenticated", comment: "User is not authenticated")
        case .failedToCreate(let entity):
            return NSLocalizedString("error.failedToCreate", comment: "Failed to create \(entity)")
        case .failedToFetch(let entity):
            return NSLocalizedString("error.failedToFetch", comment: "Failed to fetch \(entity)")
        case .failedToUpdate(let entity):
            return NSLocalizedString("error.failedToUpdate", comment: "Failed to update \(entity)")
        case .failedToDelete(let entity):
            return NSLocalizedString("error.failedToDelete", comment: "Failed to delete \(entity)")
        case .invalidData(let entity):
            return NSLocalizedString("error.invalidData", comment: "Invalid \(entity) data")
        case .networkError:
            return NSLocalizedString("error.networkError", comment: "Network error occurred")
        case .unknownError(let message):
            return NSLocalizedString("error.unknown", comment: "An unknown error occurred: \(message)")
        }
    }
}
