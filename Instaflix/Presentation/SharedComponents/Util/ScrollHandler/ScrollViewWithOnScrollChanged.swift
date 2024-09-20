//
//  ScrollViewWithOnScrollChanged.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 14/09/24.
//

import SwiftUI

public struct ScrollViewWithOnScrollChanged<Content:View>: View {

    let axes: Axis.Set
    let showsIndicators: Bool
    let content: Content
    let onScrollChanged: (_ origin: CGPoint) -> ()
    @State private var coordinateSpaceID: String = UUID().uuidString

    public init(
        _ axes: Axis.Set = .vertical,
        showsIndicators: Bool = false,
        @ViewBuilder content: () -> Content,
        onScrollChanged: @escaping (_ origin: CGPoint) -> ()) {
            self.axes = axes
            self.showsIndicators = showsIndicators
            self.content = content()
            self.onScrollChanged = onScrollChanged
        }

    public var body: some View {
        ScrollView(axes, showsIndicators: showsIndicators) {
            LocationReader(coordinateSpace: .named(coordinateSpaceID), onChange: onScrollChanged)
            content
        }
        .coordinateSpace(name: coordinateSpaceID)
    }
}

struct ScrollViewWithOnScrollChanged_Previews: PreviewProvider {

    struct PreviewView: View {

        @State private var yPosition: CGFloat = 0

        var body: some View {
            ScrollViewWithOnScrollChanged {
                VStack {
                    ForEach(0..<30) { x in
                        Text("x: \(x)")
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .cornerRadius(10)
                            .background(Color.instaflixRed)
                            .padding()
                            .id(x)
                    }
                }
            } onScrollChanged: { origin in
                yPosition = origin.y
            }
            .overlay(Text("Offset: \(yPosition)"))
        }
    }

    static var previews: some View {
        PreviewView()
    }
}
