//
//  ItemCell.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 14/09/24.
//

import SwiftUI

struct ItemCell<T: ItemInformationProtocol>: View {

    typealias Dimens = ItemCellConstants.Dimens
    typealias Values = ItemCellConstants.Values
    typealias Assets = ItemCellConstants.Assets
    typealias Strings = ItemCellConstants.Strings

    var model: T
    var isRecentlyAdded: Bool = false
    var topTenRanking: Int? = nil
    var cellWidth: CGFloat = Dimens.cellWidth
    var cellHeight: CGFloat = Dimens.cellHeight

    var body: some View {
        ZStack(alignment: .leading) {
            HStack(alignment: .bottom, spacing: -(cellWidth * 0.18)) {
                if let topTenRanking {
                    Text(String(topTenRanking))
                        .lineLimit(Values.lineLimit)
                        .font(.system(size: Values.topTenFontSize))
                        .offset(y: 20)
                        .zIndex(Values.one)
                }
                ZStack(alignment: .bottom) {
                    if let url = InstaflixUtils.getImageUrl(filePath: model.posterPath, type: .poster) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .frame(maxWidth: .infinity)
                        } placeholder: {
                            VStack {
                                ProgressView()
                                Text(model.title)
                                    .font(.footnote)
                            }
                            .frame(width: cellWidth, height: cellHeight)
                            .border(Color.gray, width: Values.one)
                            .foregroundStyle(Color.instaflixWhite)
                        }
                    } else {
                        VStack {
                            Image(Assets.noImageAvaiable)
                                .resizable()
                            Text(model.title)
                                .font(.footnote)
                        }
                        .frame(width: cellWidth, height: cellHeight)
                        .border(Color.gray, width: Values.one)
                        .foregroundStyle(Color.instaflixWhite)
                    }
                    VStack {
                        Text(Strings.recentlyAdded)
                            .padding(.horizontal, Dimens.spacing4)
                            .padding(.vertical, Dimens.spacing2)
                            .frame(maxWidth: .infinity)
                            .background(Color.instaflixRed)
                            .clipShape(.rect(cornerRadius: Dimens.spacing2))
                            .offset(y: Dimens.spacing2)
                            .lineLimit(Values.lineLimit)
                            .font(.caption2)
                            .fontWeight(.bold)
                            .minimumScaleFactor(0.1)
                            .padding(.horizontal, Dimens.spacing8)
                            .opacity(isRecentlyAdded ? Values.one : .zero)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, Dimens.spacing6)

                }
                .frame(width: cellWidth, height: cellHeight)

            }
        }
        .foregroundStyle(.instaflixWhite)
    }
}

#Preview {
    ZStack {
        Color.instaflixBlack.ignoresSafeArea()
        ScrollView {
            ItemCell(model: MovieDomainModel.mockData(), isRecentlyAdded: false, cellWidth: 90, cellHeight: 140)
            ItemCell(model: MovieDomainModel.mockData(), isRecentlyAdded: true, cellWidth: 90, cellHeight: 140)
            ItemCell(model: MovieDomainModel.mockData(), isRecentlyAdded: true, topTenRanking: 10, cellWidth: 90, cellHeight: 140)
        }
    }
}
