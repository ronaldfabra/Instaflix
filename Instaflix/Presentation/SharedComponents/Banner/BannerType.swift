//
//  BannerType.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 17/09/24.
//

import Foundation
import SwiftUI

enum BannerType: Equatable {
    var id: Self { self }
    case success(message: String, isPersistent: Bool = false)
    case error(message: String, isPersistent: Bool = true)
    case warning(message: String, isPersistent: Bool = false)

    var backgroundColor: Color {
        switch self {
            case .success: return Color.green
            case .warning: return Color.yellow
            case .error: return Color.instaflixRed
        }
    }
    var imageName: String {
        switch self {
            case .success: return BannerViewConstants.Assets.successIcon
            case .warning: return BannerViewConstants.Assets.warningIcon
            case .error: return BannerViewConstants.Assets.errorIcon
        }
    }

    var message: String {
        switch self {
            case let .success(message, _), let .warning(message, _), let .error(message, _):
                return message
        }
    }
    var isPersistent: Bool {
        switch self {
            case let .success(_, isPersistent), let .warning(_, isPersistent), let .error(_, isPersistent):
                return isPersistent
        }
    }
}
