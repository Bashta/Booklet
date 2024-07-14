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
            return String(localized: "auth.error.invalidEmail")
        case .weakPassword:
            return String(localized: "auth.error.weakPassword")
        case .emailAlreadyInUse:
            return String(localized: "auth.error.emailAlreadyInUse")
        case .userNotFound:
            return String(localized: "auth.error.userNotFound")
        case .wrongPassword:
            return String(localized: "auth.error.wrongPassword")
        case .networkError:
            return String(localized: "auth.error.networkError")
        case .unknownError(let message):
            return String(localized: "auth.error.unknown \(message)")
        }
    }
}
