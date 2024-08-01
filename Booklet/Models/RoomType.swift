//
//  RoomType.swift
//  Booklet
//
//  Created by Erison Veshi on 1.8.24.
//


import Foundation
import FirebaseFirestoreSwift

struct RoomType: Identifiable, Codable {
    @DocumentID var id: String?
    var uuid: UUID = .init()
    let name: String
    let description: String
}
