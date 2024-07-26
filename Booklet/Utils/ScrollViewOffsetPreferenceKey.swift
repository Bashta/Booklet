//
//  ScrollViewOffsetPreferenceKey.swift
//  Booklet
//
//  Created by Erison Veshi on 27.7.24.
//

import SwiftUI

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue = CGPoint.zero
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        value += nextValue()
    }
}
