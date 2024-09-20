//
//  View+Extension.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 17/09/24.
//

import SwiftUI

public extension View {
    /// Get the frame of the View
    ///
    /// Adds a GeometryReader to the background of a View.
    func readingFrame(coordinateSpace: CoordinateSpace = .global, onChange: @escaping (_ frame: CGRect) -> ()) -> some View {
        background(FrameReader(coordinateSpace: coordinateSpace, onChange: onChange))
    }

    /// Get the center point of the View
    ///
    /// Adds a 0px GeometryReader to the background of a View.
    func readingLocation(coordinateSpace: CoordinateSpace = .global, onChange: @escaping (_ location: CGPoint) -> ()) -> some View {
        background(LocationReader(coordinateSpace: coordinateSpace, onChange: onChange))
    }

    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                    isActive: binding
                ) {
                    EmptyView()
                }
                .accessibilityHidden(true)
                self
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
            }
        }
        .navigationViewStyle(.stack)
    }

    @ViewBuilder
    func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            content(self)
        } else {
            self
        }
    }

    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    ///     George-J-E/HidingViews. https://github.com/George-J-E/HidingViews
    @ViewBuilder func hidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }

    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}
