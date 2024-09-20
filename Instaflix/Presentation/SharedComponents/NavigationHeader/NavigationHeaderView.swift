//
//  NavigationHeaderView.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import SwiftUI

struct NavigationHeaderView: View {

    typealias Dimens = NavigationHeaderViewConstants.Dimens
    typealias Values = NavigationHeaderViewConstants.Values
    typealias Assets = NavigationHeaderViewConstants.Assets

    var showBackButton: Bool = false
    var onBackPressed: (() -> Void)? = nil
    var onClosePressed: (() -> Void)? = nil

    var body: some View {
        HStack(spacing: Dimens.spacing8) {
            if showBackButton {
                Circle()
                    .fill(.instaflixBlack.opacity(Values.colorOpacity))
                    .overlay(
                        Image(systemName: Assets.backIcon)
                            .offset(y: Values.imageOffset)
                    )
                    .frame(width: Dimens.buttonSize, height: Dimens.buttonSize)
                    .onTapGesture {
                        onBackPressed?()
                    }
            }
            Spacer()
            Circle()
                .fill(.instaflixBlack.opacity(Values.colorOpacity))
                .overlay(
                    Image(systemName: Assets.closeIcon)
                        .offset(y: Values.imageOffset)
                )
                .frame(width: Dimens.buttonSize, height: Dimens.buttonSize)
                .onTapGesture {
                    onClosePressed?()
                }
        }
        .foregroundStyle(Color.instaflixWhite)
        .font(.subheadline)
        .fontWeight(.bold)
        .padding(Dimens.spacing8)
        .frame(maxWidth: .infinity, alignment: .top)
    }
}

#Preview {
    ZStack(alignment: .top) {
        Color.instaflixBlack.ignoresSafeArea()
        NavigationHeaderView()
    }
}
