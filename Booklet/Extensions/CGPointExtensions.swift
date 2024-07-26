//
//  CGPointExtensions.swift
//  Booklet
//
//  Created by Erison Veshi on 27.7.24.
//

import CoreGraphics

extension CGPoint {
    static func + (lhs: Self, rhs: Self) -> Self {
        CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    static func += (lhs: inout Self, rhs: Self) {
        lhs = lhs + rhs
    }
}
