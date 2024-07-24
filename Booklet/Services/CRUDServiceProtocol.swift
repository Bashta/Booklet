//
//  CRUDServiceProtocol.swift
//  Booklet
//
//  Created by Erison Veshi on 24.7.24.
//

import Foundation

protocol CRUDServiceProtocol<Entity> {
   
    associatedtype Entity: Identifiable & Codable

    func create(_ entity: Entity) async throws
    func read() async throws -> [Entity]
    func update(_ entity: Entity) async throws
    func delete(_ id: String) async throws
}

/// Performs a service call with error handling and mapping to `ServiceError` types.
///
/// This function wraps an asynchronous operation, providing consistent error handling
/// for various types of errors that may occur during service calls.
///
/// - Parameters:
///   - entity: A string representing the name of the entity being operated on.
///     This is used in error messages for context.
///   - action: An asynchronous closure that performs the actual service call.
///     This closure can throw errors and return a value of type `T`.
///
/// - Returns: The result of the `action` closure if it completes successfully.
///
/// - Throws: A `ServiceError` enum case depending on the type of error encountered:
///   - If the original error is already a `ServiceError`, it's rethrown as-is.
///   - `ServiceError.invalidData` if a `DecodingError` occurs.
///   - `ServiceError.networkError` if an `NSError` with `NSURLErrorDomain` occurs.
///   - `ServiceError.unknownError` for any other type of error.
///
/// - Note: This function is designed to be used within service layer implementations
///   to provide consistent error handling and mapping across different service calls.
func performServiceCall<T>(
    entity: String,
    action: @escaping () async throws -> T
) async throws -> T {
    do {
        return try await action()
    } catch let error as ServiceError {
        throw error
    } catch {
        switch error {
        case is DecodingError:
            throw ServiceError.invalidData(entity)
        case let nsError as NSError:
            if nsError.domain == NSURLErrorDomain {
                throw ServiceError.networkError
            } else {
                throw ServiceError.unknownError(nsError.localizedDescription)
            }
        default:
            throw ServiceError.unknownError(error.localizedDescription)
        }
    }
}
