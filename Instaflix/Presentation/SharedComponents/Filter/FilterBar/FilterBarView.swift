//
//  FilterBarView.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 14/09/24.
//

import SwiftUI

struct FilterBarView: View {

    typealias Dimens = FilterBarViewConstants.Dimens
    typealias Assets = FilterBarViewConstants.Assets
    typealias Values = FilterBarViewConstants.Values

    var filters: [FilterDomainModel] = []
    @Binding var selectedFilter: FilterDomainModel?
    var showClearButton: Bool = false
    var onFilterPressed: ((FilterDomainModel) -> Void)? = nil
    var onClosePressed: (() -> Void)? = nil

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                clearButton
                    .if(!showClearButton || selectedFilter == nil) { content in
                        content.hidden(true, remove: true)
                    }
                filterList
            }
            .padding(.vertical, Dimens.spacing4)
        }
        .scrollIndicators(.hidden)
        .animation(.bouncy, value: selectedFilter)
    }
}

// MARK: clearButton
extension FilterBarView {
    private var clearButton: some View {
        Image(systemName: Assets.closeIcon)
            .padding(Dimens.spacing8)
            .background(
                Circle()
                    .stroke(lineWidth: Values.one)
            )
            .foregroundStyle(.instaflixLightGray)
            .background(Color.instaflixBlack.opacity(Values.backgroundOpacity))
            .onTapGesture {
                onClosePressed?()
            }
            .transition(.move(edge: .leading))
            .padding(.leading, Dimens.spacing16)
    }
}

// MARK: filterList
extension FilterBarView {
    private var filterList: some View {
        HStack {
            ForEach(filters, id: \.self) { filter in
                if showClearButton {
                    if selectedFilter == nil || selectedFilter == filter {
                        filterCell(filter: filter)
                            .padding(.leading, ((selectedFilter == nil) && filter == filters.first) ? Dimens.spacing16 : .zero)
                    }
                } else {
                    filterCell(filter: filter)
                        .padding(.leading, .zero)
                }
            }
        }
        .padding(.leading, showClearButton ? .zero : Dimens.spacing16)
    }

    private func filterCell(filter: FilterDomainModel) -> some View {
        FilterCell(
            title: filter.title,
            isDropdown: filter.isDropdown,
            isSelected: selectedFilter == filter
        )
        .background(Color.instaflixBlack.opacity(Values.backgroundOpacity))
        .onTapGesture {
            selectedFilter = filter
            onFilterPressed?(filter)
        }
    }
}

fileprivate struct FilterBarViewPreview: View {

    var filters: [FilterDomainModel] = FilterDomainModel.mockData
    @State var selectedFilter: FilterDomainModel? = nil

    var body: some View {
        FilterBarView(
            filters: filters,
            selectedFilter: $selectedFilter,
            showClearButton: false,
            onFilterPressed: { filterSelected in
                selectedFilter = filterSelected
            },
            onClosePressed: {
                selectedFilter = nil
            })
    }
}

#Preview {
    FilterBarViewPreview()
}
