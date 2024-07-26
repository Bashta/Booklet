//
//  ObservableScrollView.swift
//  Booklet
//
//  Created by Erison Veshi on 27.7.24.
//

import SwiftUI

/// A custom ScrollView that reports its scroll offset.
///
/// `ObservableScrollView` wraps a standard SwiftUI `ScrollView` and uses the preference
/// key system to observe and report scroll offset changes. This allows for creating
/// scrollable content with the ability to react to or use the current scroll position.
///
/// Example usage:
/// ```
/// @State private var scrollOffset: CGPoint = .zero
///
/// var body: some View {
///     ObservableScrollView(axis: .vertical, scrollOffset: $scrollOffset) { proxy in
///         VStack {
///             ForEach(0..<100) { i in
///                 Text("Row \(i)")
///             }
///         }
///     }
/// }
/// ```
///
/// - Note: This view uses a `GeometryReader` internally, which may affect layout in some cases.
///   Be mindful of potential layout issues when nesting this view deeply or in complex view hierarchies.
struct ObservableScrollView<Content: View>: View {
    
    /// The scroll axes that should be enabled for this scroll view.
    let axis: Axis.Set
   
    /// A binding to the current scroll offset of the scroll view.
    ///
    /// This binding updates whenever the scroll position changes, allowing the parent view
    /// to react to or use the current scroll position.
    @Binding var scrollOffset: CGPoint
    
    /// A closure that provides the content of the scroll view.
    ///
    /// The closure is passed a `ScrollViewProxy`, which can be used to programmatically
    /// scroll to specific positions or views within the scroll view.
    let content: (ScrollViewProxy) -> Content

    /// A namespace for the coordinate space of the scroll view.
    @Namespace private var scrollSpace

    /// The body of the `ObservableScrollView`.
    ///
    /// This computed property constructs the view hierarchy for the custom scroll view,
    /// including the mechanism for tracking scroll offset.
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
