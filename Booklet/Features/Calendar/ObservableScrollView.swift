//
//  ObservableScrollView.swift
//  Booklet
//
//  Created by Erison Veshi on 27.7.24.
//

import SwiftUI

struct ObservableScrollView<Content: View>: View {
    let axis: Axis.Set
    @Binding var scrollOffset: CGPoint
    let content: (ScrollViewProxy) -> Content
    @Namespace private var scrollSpace

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(axis) {
                content(proxy)
                    .background(GeometryReader { geo in
                        Color.clear
                            .preference(
                                key: ScrollViewOffsetPreferenceKey.self,
                                value: geo.frame(in: .named(scrollSpace)).origin
                            )
                    })
            }
        }
        .coordinateSpace(name: scrollSpace)
        .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
            scrollOffset = value
        }
    }
}
