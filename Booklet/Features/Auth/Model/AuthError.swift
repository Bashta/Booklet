//
//  AuthError.swift
//  Booklet
//
//  Created by Erison Veshi on 14.7.24.
//

import Foundation

enum AuthError: LocalizedError {
    case invalidEmail
    case weakPassword
    case emailAlreadyInUse
    case userNotFound
    case wrongPassword
    case networkError
    case unknownError(String)

    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return "The email address is badly formatted."
        case .weakPassword:
            return "The password must be at least 6 characters long."
        case .emailAlreadyInUse:
            return "The email address is already in use by another account."
        case .userNotFound:
            return "There is no user record corresponding to this identifier."
        case .wrongPassword:
            return "The password is invalid."
        case .networkError:
            return "A network error occurred. Please check your connection and try again."
        case .unknownError(let message):
            return "An unknown error occurred: \(message)"
        }
    }
}
