//
//  BackdropImageView.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import SwiftUI

struct BackdropImageView: View {

    typealias Dimens = BackdropImageViewConstants.Dimens
    typealias Assets = BackdropImageViewConstants.Assets
    typealias Values = BackdropImageViewConstants.Values

    let filePath: String?

    var body: some View {
        if let url = InstaflixUtils.getImageUrl(filePath: filePath, type: .backdropPath) {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: Dimens.imageHeight)
            } placeholder: {
                VStack {
                    ProgressView()
                }
                .frame(maxWidth: .infinity)
                .frame(height: Dimens.imageHeight)
                .border(Color.instaflixLightGray, width: Values.one)
                .foregroundStyle(Color.instaflixWhite.opacity(Values.opacity))
            }

        } else {
            VStack {
                Image(Assets.noImageAvaiable)
                    .resizable()
            }
            .frame(maxWidth: .infinity)
            .frame(height: Dimens.imageHeight)
            .border(Color.instaflixLightGray, width: Values.one)
            .foregroundStyle(Color.instaflixWhite.opacity(Values.opacity))
        }
    }
}

#Preview {
    BackdropImageView(filePath: "/7KGdTzKux4fp5sW7hUM33NWqBU1.jpg")
}
