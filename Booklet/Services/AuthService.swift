//
//  AuthService.swift
//  Booklet
//
//  Created by Erison Veshi on 13.7.24.
//

import FirebaseAuth

protocol AuthServiceProtocol {
    func signIn(email: String, password: String) async throws -> AppUser
    func signUp(email: String, password: String) async throws -> AppUser
    func signOut() async throws
    func getCurrentUser() -> AppUser?
    func addStateDidChangeListener(_ listener: @escaping (AppUser?) -> Void) -> Any
    func removeStateDidChangeListener(_ listenerHandle: Any)
}

class AuthService: AuthServiceProtocol {
    private let auth = Auth.auth()
    
    func signIn(email: String, password: String) async throws -> AppUser {
        do {
            let authDataResult = try await auth.signIn(withEmail: email, password: password)
            return AppUser(id: authDataResult.user.uid, email: authDataResult.user.email)
        } catch let error as NSError {
            throw self.handleFirebaseError(error)
        }
    }
    
    func signUp(email: String, password: String) async throws -> AppUser {
        do {
            let authDataResult = try await auth.createUser(withEmail: email, password: password)
            return AppUser(id: authDataResult.user.uid, email: authDataResult.user.email)
        } catch let error as NSError {
            throw self.handleFirebaseError(error)
        }
    }
    
    func signOut() async throws {
        try auth.signOut()
    }
    
    func getCurrentUser() -> AppUser? {
        guard let currentUser = auth.currentUser else { return nil }
        return AppUser(id: currentUser.uid, email: currentUser.email)
    }
    
    func addStateDidChangeListener(_ listener: @escaping (AppUser?) -> Void) -> Any {
        return auth.addStateDidChangeListener { _, user in
            listener(user.map { AppUser(id: $0.uid, email: $0.email) })
        }
    }
    
    func removeStateDidChangeListener(_ listenerHandle: Any) {
        if let handle = listenerHandle as? AuthStateDidChangeListenerHandle {
            auth.removeStateDidChangeListener(handle)
        }
    }
}

// MARK: - Error handling

private extension AuthService {
    func handleFirebaseError(_ error: NSError) -> AuthError {
        let authError = AuthErrorCode(_nsError: error)
        switch authError.code {
        case .invalidEmail:
            return .invalidEmail
        case .weakPassword:
            return .weakPassword
        case .emailAlreadyInUse:
            return .emailAlreadyInUse
        case .userNotFound:
            return .userNotFound
        case .wrongPassword:
            return .wrongPassword
        case .networkError:
            return .networkError
        default:
            return .unknownError(error.localizedDescription)
        }
    }
}
