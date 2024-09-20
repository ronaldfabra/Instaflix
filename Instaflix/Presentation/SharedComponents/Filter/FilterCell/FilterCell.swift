//
//  FilterCell.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 14/09/24.
//

import SwiftUI

struct FilterCell: View {

    typealias Dimens = FilterCellConstants.Dimens
    typealias Assets = FilterCellConstants.Assets
    typealias Values = FilterCellConstants.Values

    var title: String
    var isDropdown: Bool = false
    var isSelected: Bool = false

    var body: some View {
        HStack(spacing: Dimens.spacing4) {
            Text(title)
            if isDropdown {
                Image(systemName: Assets.arrowDown)
            }
        }
        .padding(.horizontal, Dimens.spacing16)
        .padding(.vertical, Dimens.spacing8)
        .background(
            ZStack {
                Capsule(style: .circular)
                    .fill(Color.instaflixDarkGray)
                    .opacity(isSelected ? Values.one : .zero)
                Capsule(style: .circular)
                    .stroke(lineWidth: Values.one)
            }
        )
        .foregroundStyle(Color.instaflixLightGray)
    }
}

#Preview {
    FilterCell(title: "movie")
}
