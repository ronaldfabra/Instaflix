//
//  BannerViewModel.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 17/09/24.
//

import Foundation
import SwiftUI

@Observable
class BannerViewModel: ObservableObject {
    var isAnimating = false
    var dragOffset = CGSize.zero
    var bannerType: BannerType? {
        didSet {
            withAnimation {
                switch bannerType {
                    case .none:
                        isAnimating = false
                    case .some:
                        isAnimating = true
                }
            }
        }
    }
    let maxDragOffsetHeight: CGFloat = -50.0

    func setBanner(banner: BannerType) {
        withAnimation {
            self.bannerType = banner
        }
    }

    func removeBanner() {
        withAnimation {
            self.bannerType = nil
            self.isAnimating = false
            self.dragOffset = .zero
        }
    }
}
