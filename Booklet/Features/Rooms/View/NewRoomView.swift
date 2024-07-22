//
//  NewRoomView.swift
//  Booklet
//
//  Created by Erison Veshi on 22.7.24.
//

import SwiftUI

struct NewRoomView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.serviceLocator.roomViewModel) private var roomViewModel
    
    @State private var newRoom = Room.empty
    
    var body: some View {
        NavigationStack {
            Form {
                Section("room.form.details") {
                    TextField("room.form.number", text: $newRoom.number)
                    Picker("room.form.type", selection: $newRoom.type) {
                        ForEach(Room.RoomType.allCases, id: \.self) { type in
                            Text(type.rawValue.capitalized).tag(type)
                        }
                    }
                    Stepper("room.form.capacity \(newRoom.capacity)", value: $newRoom.capacity, in: 1...10)
                    TextField("room.form.price", value: $newRoom.pricePerNight, format: .currency(code: "USD"))
                }
                
                Section("room.form.amenities") {
                    ForEach(newRoom.amenities.indices, id: \.self) { index in
                        TextField("room.form.amenity", text: $newRoom.amenities[index])
                    }
                    Button("room.form.addAmenity") {
                        newRoom.amenities.append("")
                    }
                }
            }
            .navigationTitle("room.form.title")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("common.cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("common.save") {
                        Task {
                            await roomViewModel.addRoom(newRoom)
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NewRoomView()
}
