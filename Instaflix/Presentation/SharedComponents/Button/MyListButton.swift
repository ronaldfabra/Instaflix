//
//  MyListButton.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import SwiftUI

struct MyListButton: View {

    var isOnMyList: Bool = false
    var onButtonPressed: ((Bool) -> Void)? = nil

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Image(systemName: InstaflixContants.Icons.checkmark)
                    .opacity(isOnMyList ? 1 : .zero)
                    .rotationEffect(Angle(degrees: isOnMyList ? .zero : 180))

                Image(systemName: InstaflixContants.Icons.plus)
                    .opacity(isOnMyList ? .zero : 1)
                    .rotationEffect(Angle(degrees: isOnMyList ? -180 : .zero))
            }
            .font(.title)

            Text(InstaflixContants.Strings.myList)
                .font(.caption)
        }
        .padding(8)
        .background(Color.instaflixBlack.opacity(0.001))
        .animation(.bouncy, value: isOnMyList)
        .onTapGesture {
            onButtonPressed?(!isOnMyList)
        }
    }
}

fileprivate struct MyListButtonPreview: View {
    @State private var isOnMyList: Bool = false

    var body: some View {
        MyListButton(isOnMyList: isOnMyList) { isFavorite in
            isOnMyList = isFavorite
        }
    }
}

#Preview {
    MyListButtonPreview()
}
