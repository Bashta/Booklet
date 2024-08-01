//
//  RoomView.swift
//  Booklet
//
//  Created by Erison Veshi on 22.7.24.
//

import SwiftUI

struct RoomView: View {
    
    @Environment(\.serviceLocator.roomViewModel) private var roomViewModel
    
    @State private var isShowingNewRoomView = false
    
    var body: some View {
        List {
            ForEach(roomViewModel.rooms) { room in
                RoomRowView(room: room)
            }
            .onDelete(perform: deleteRoom)
        }
        .overlay {
            if roomViewModel.rooms.isEmpty && !roomViewModel.isLoading {
                ContentUnavailableView {
                    Label("room.noRooms", systemImage: "bed.double")
                } description: {
                    Text("room.noRooms.description")
                } actions: {
                    Button("room.addNew") {
                        isShowingNewRoomView = true
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                AddEntityButton(title: "room.addNew", action: { isShowingNewRoomView = true })
            }
        }
        .sheet(isPresented: $isShowingNewRoomView) {
            NewRoomView()
        }
        .task {
            await roomViewModel.fetchRooms()
        }
        .loading(isLoading: roomViewModel.isLoading, title: "room.loading.title", description: "room.loading.description")
    }
    
    private func deleteRoom(at offsets: IndexSet) {
        Task {
            for index in offsets {
                if let id = roomViewModel.rooms[index].id {
                    await roomViewModel.deleteRoom(id)
                }
            }
        }
    }
}

struct RoomRowView: View {
    let room: Room
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Room \(room.number)")
                .font(.headline)
            Text(room.type.capitalized)
                .font(.subheadline)
            Text("Capacity: \(room.capacity)")
            Text("Price: \(room.pricePerNight, format: .currency(code: "USD"))/night")
        }
    }
}
