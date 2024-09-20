//
//  CategorySectionView.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import SwiftUI


struct CategorySectionView<T: ItemInformationProtocol & Identifiable & Decodable>: View {

    typealias Dimens = CategorySectionViewConstants.Dimens

    let category: CategoryDomailModel<T>
    var onItemPressed: ((T) -> Void)? = nil
    var onPaginateIfNeeded: (() -> Void)? = nil

    var body: some View {
        if !category.list.isEmpty {
            VStack(alignment: .leading, spacing: Dimens.spacing10) {
                Text(category.category.title.capitalized)
                    .fontWeight(.bold)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(Array(category.list.enumerated()), id: \.offset) { index, item in
                            VStack {
                                ItemCell(
                                    model: item,
                                    isRecentlyAdded: InstaflixUtils.isRecentlyAdded(dateStr: item.releaseDate ?? .empty),
                                    cellWidth: Dimens.cellWidth,
                                    cellHeight: Dimens.cellHeight
                                )
                                .onAppear {
                                    if item.id == category.list.last?.id {
                                        onPaginateIfNeeded?()
                                    }
                                }
                                .onTapGesture {
                                    onItemPressed?(item)
                                }
                                .foregroundStyle(.instaflixWhite)
                            }
                        }
                    }
                }
                .frame(height: Dimens.cellHeight)
            }
            .foregroundStyle(.instaflixWhite)
        }
    }
}

#Preview {
    ZStack {
        Color.instaflixBlack.ignoresSafeArea()
        CategorySectionView(category: .init(category: .popular, list: [MovieDomainModel.mockData(),
                                                                       MovieDomainModel.mockData(),
                                                                       MovieDomainModel.mockData(),
                                                                       MovieDomainModel.mockData(),
                                                                       MovieDomainModel.mockData(),
                                                                       MovieDomainModel.mockData(),
                                                                       MovieDomainModel.mockData()]))
    }
}
