//
//  ScrollViewOffsetPreferenceKey.swift
//  Booklet
//
//  Created by Erison Veshi on 27.7.24.
//

import SwiftUI

/// A preference key for communicating scroll view offset changes.
///
/// This preference key is used in conjunction with SwiftUI's preference system
/// to propagate scroll offset information from a child view (typically inside a ScrollView)
/// to a parent view.
///
/// It's primarily designed to work with custom scroll view implementations
/// that need to track and report their current scroll position.
///
/// Usage example:
/// ```
/// .background(GeometryReader { geometry in
///     Color.clear.preference(
///         key: ScrollViewOffsetPreferenceKey.self,
///         value: geometry.frame(in: .named("scrollView")).origin
///     )
/// })
/// ```
///
/// Then, in a parent view:
/// ```
/// .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
///     // Handle the new scroll offset
///     self.currentScrollOffset = value
/// }
/// ```
struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    /// The default value for the scroll offset.
    ///
    /// This is set to `CGPoint.zero`, representing the top-left corner of the scroll view.
    static var defaultValue = CGPoint.zero
    
    /// Combines an old value with a new value to produce a final value for the preference.
    ///
    /// This method is called by SwiftUI to resolve multiple preferences set on different views
    /// into a single value. In this case, it adds the new value to the existing value,
    /// effectively accumulating scroll offsets.
    ///
    /// - Parameters:
    ///   - value: The current value of the preference.
    ///   - nextValue: A closure that returns the next value to be combined.
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        value += nextValue()
    }
}
