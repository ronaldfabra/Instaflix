//
//  LocationReader.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 14/09/24.
//

import SwiftUI

public struct LocationReader: View {

    let coordinateSpace: CoordinateSpace
    let onChange: (_ location: CGPoint) -> Void

    public init(coordinateSpace: CoordinateSpace, onChange: @escaping (_ location: CGPoint) -> Void) {
        self.coordinateSpace = coordinateSpace
        self.onChange = onChange
    }

    public var body: some View {
        FrameReader(coordinateSpace: coordinateSpace) { frame in
            onChange(CGPoint(x: frame.midX, y: frame.midY))
        }
        .frame(width: 0, height: 0, alignment: .center)
    }
}

struct LocationReader_Previews: PreviewProvider {

    struct PreviewView: View {

        @State private var yOffset: CGFloat = 0

        var body: some View {
            ScrollView(.vertical) {
                VStack {
                    Text("Hello, world!")
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                        .cornerRadius(10)
                        .background(Color.green)
                        .padding()
                        .readingLocation { location in
                            yOffset = location.y
                        }

                    ForEach(0..<30) { x in
                        Text("")
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .cornerRadius(10)
                            .background(Color.green)
                            .padding()
                    }
                }
            }
            .coordinateSpace(name: "test")
            .overlay(Text("Offset: \(yOffset)"))
        }
    }

    static var previews: some View {
        PreviewView()
    }
}
