//
//  InstaflixApp.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import SwiftUI
import SwiftData

@main
struct InstaflixApp: App {
    let bannerViewModel = BannerViewModel()
    let networkMonitor = NetworkMonitor()
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                if let type = bannerViewModel.bannerType {
                    BannerView(banner: type)
                }
            }
            .onChange(of: networkMonitor.isConnected) { _, isConnected in
                if !isConnected {
                    bannerViewModel.setBanner(banner: .error(message: NetworkErrorType.internetConnection.errorDescription, 
                                                             isPersistent: true))
                }
            }
            .environmentObject(bannerViewModel)
            .environment(networkMonitor)
        }
        .modelContainer(InstaflixModelContainer.shared.sharedModelContainer)
    }
}
