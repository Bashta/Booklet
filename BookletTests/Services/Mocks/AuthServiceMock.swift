//
//  AuthServiceMock.swift
//  BookletTests
//
//  Created by Erison Veshi on 21.7.24.
//

import Foundation
@testable import Booklet

class AuthServiceMock: AuthServiceProtocol {
    var mockUserId: String?

    func getCurrentUserId() -> String? {
        return mockUserId
    }

    func signIn(email: String, password: String) async throws -> AppUser { fatalError("Not implemented") }
    func signUp(email: String, password: String) async throws -> AppUser { fatalError("Not implemented") }
    func signOut() async throws { fatalError("Not implemented") }
    func getCurrentUser() -> AppUser? { fatalError("Not implemented") }
    func addStateDidChangeListener(_ listener: @escaping (AppUser?) -> Void) -> Any { fatalError("Not implemented") }
    func removeStateDidChangeListener(_ listenerHandle: Any) { fatalError("Not implemented") }
}
