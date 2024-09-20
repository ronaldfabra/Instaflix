//
//  ErrorHandlerModifier.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 19/09/24.
//

import SwiftUI

public struct ErrorHandlerModifier: ViewModifier {

    @EnvironmentObject var bannerViewModel: BannerViewModel

    public func body(content: Content) -> some View {
        ZStack {
            content
            if let type = bannerViewModel.bannerType {
                BannerView(banner: type)
            }
        }
    }
}

public extension View {
    internal func errorHandlerModifier() -> some View {
        modifier(ErrorHandlerModifier())
    }
}
