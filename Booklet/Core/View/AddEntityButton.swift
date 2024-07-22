//
//  AddEntityButton.swift
//  Booklet
//
//  Created by Erison Veshi on 22.7.24.
//

import SwiftUI

struct AddEntityButton: View {
    let title: LocalizedStringKey
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Label(title, systemImage: "plus")
                .foregroundStyle(Color.accentColor)
        }
    }
}

#Preview {
    AddEntityButton(title: "", action: {})
}
