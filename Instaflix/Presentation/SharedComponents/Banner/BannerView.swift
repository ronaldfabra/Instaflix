//
//  BannerView.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 17/09/24.
//

import SwiftUI

struct BannerView: View {

    typealias Dimens = BannerViewConstants.Dimens
    typealias Values = BannerViewConstants.Values
    typealias Assets = BannerViewConstants.Assets

    @EnvironmentObject private var bannerService: BannerViewModel
    @State private var showAllText: Bool = false
    let banner: BannerType

    var body: some View {
        VStack {
            Group {
                bannerContent
            }
        }
        .onAppear {
            guard !banner.isPersistent else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + Values.delayNotification) {
                withAnimation {
                    bannerService.isAnimating = false
                    bannerService.bannerType = nil
                }
            }
        }
        .offset(y: bannerService.dragOffset.height)
        .opacity(bannerService.isAnimating ? max(.zero, (Values.one - Double(bannerService.dragOffset.height) / bannerService.maxDragOffsetHeight)) : .zero)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal)
    }
}

// MARK: bannerContent
extension BannerView {
    private var bannerContent: some View {
        HStack(spacing: Dimens.spacing10) {
            Image(systemName: banner.imageName)
                .padding(Dimens.spacing5)
                .foregroundStyle(.instaflixWhite)
                .background(banner.backgroundColor)
                .cornerRadius(Dimens.spacing5)
                .shadow(
                    color: .instaflixBlack.opacity(Values.shadowOpacity),
                    radius: Dimens.spacing3,
                    x: -Dimens.spacing3,
                    y: Dimens.spacing4
                )
            VStack(spacing: Dimens.spacing5) {
                Text(banner.message)
                    .foregroundStyle(.instaflixBlack)
                    .fontWeight(.light)
                    .font(banner.message.count > Values.maxLettersMessage ? .caption : .footnote)
                    .multilineTextAlignment(.leading)
                    .lineLimit(showAllText ? nil : Values.lineLimit)
                if banner.message.count > Values.maxLettersToShowArrow && banner.isPersistent {
                    arrowIcon
                }
            }
            if banner.isPersistent {
                closeButton
            }
        }
        .padding(Dimens.spacing8)
        .padding(.trailing, Dimens.spacing2)
        .background(.instaflixLightGray)
        .cornerRadius(Dimens.spacing10)
        .shadow(radius: Dimens.spacing3, x: -Dimens.spacing2, y: Dimens.spacing2)
        .onTapGesture {
            withAnimation {
                self.showAllText.toggle()
            }
        }
    }
}

// MARK: closeButton
extension BannerView {
    private var arrowIcon: some View {
        Image(systemName: self.showAllText ? Assets.arrowUpIcon : Assets.arrowDownIcon)
            .foregroundStyle(.instaflixBlack)
            .fontWeight(.light)
    }
}

// MARK: closeButton
extension BannerView {
    private var closeButton: some View {
        Button {
            withAnimation{
                bannerService.removeBanner()
            }
        } label: {
            Image(systemName: Assets.closeIcon)
        }
        .foregroundStyle(.instaflixBlack)
        .shadow(
            color: .instaflixBlack.opacity(Values.shadowOpacity),
            radius: Dimens.spacing3,
            x: Dimens.spacing3,
            y: Dimens.spacing4
        )
    }
}
