//
//  RoomError.swift
//  Booklet
//
//  Created by Erison Veshi on 22.7.24.
//

import Foundation

enum RoomError: LocalizedError {
    case userNotAuthenticated
    case failedToCreateRoom
    case failedToFetchRooms
    case failedToUpdateRoom
    case failedToDeleteRoom
    case invalidRoomData

    var errorDescription: String? {
        switch self {
        case .userNotAuthenticated:
            return NSLocalizedString("room.error.userNotAuthenticated", comment: "User is not authenticated")
        case .failedToCreateRoom:
            return NSLocalizedString("room.error.failedToCreateRoom", comment: "Failed to create room")
        case .failedToFetchRooms:
            return NSLocalizedString("room.error.failedToFetchRooms", comment: "Failed to fetch rooms")
        case .failedToUpdateRoom:
            return NSLocalizedString("room.error.failedToUpdateRoom", comment: "Failed to update room")
        case .failedToDeleteRoom:
            return NSLocalizedString("room.error.failedToDeleteRoom", comment: "Failed to delete room")
        case .invalidRoomData:
            return NSLocalizedString("room.error.invalidRoomData", comment: "Invalid room data")
        }
    }
}
