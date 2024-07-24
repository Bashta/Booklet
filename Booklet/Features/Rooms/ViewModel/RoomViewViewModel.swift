//
//  RoomViewViewModel.swift
//  Booklet
//
//  Created by Erison Veshi on 22.7.24.
//

import Foundation

@Observable
class RoomViewViewModel {
    
    // MARK: - Properties
    
    private let roomService: any CRUDServiceProtocol<Room>

    var rooms: [Room] = []
    var selectedRoom: Room?
    var newRoom: Room = .empty
    var isAddingNewRoom = false
    var isLoading = false
    var errorMessage: String?
    
    // MARK: - Lifecycle
    
    init(roomService: any CRUDServiceProtocol<Room> = RoomService()) {
        self.roomService = roomService
    }
    
}

// MARK: - Backend Calls

@MainActor
extension RoomViewViewModel {
    func fetchRooms() async {
        isLoading = true
        do {
            rooms = try await roomService.read()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func addRoom(_ room: Room) async {
        isLoading = true
        do {
            try await roomService.create(room)
            await fetchRooms()
            isAddingNewRoom = false
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func updateRoom(_ room: Room) async {
        isLoading = true
        do {
            try await roomService.update(room)
            await fetchRooms()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func deleteRoom(_ roomId: String) async {
        isLoading = true
        do {
            try await roomService.delete(roomId)
            await fetchRooms()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
