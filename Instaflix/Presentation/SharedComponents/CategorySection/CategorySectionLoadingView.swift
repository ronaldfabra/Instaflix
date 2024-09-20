//
//  CategorySectionLoadingView.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import SwiftUI

struct CategorySectionLoadingView: View {
    var body: some View {
        CategorySectionView(category: .init(category: .popular, list: [MovieDomainModel.mockData(),
                                                                       MovieDomainModel.mockData(),
                                                                       MovieDomainModel.mockData(),
                                                                       MovieDomainModel.mockData()]))
        .redacted(reason: .placeholder)
    }
}

#Preview {
    ZStack {
        Color.instaflixBlack.ignoresSafeArea()
        CategorySectionLoadingView()
    }
}

