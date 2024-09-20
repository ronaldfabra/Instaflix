//
//  ContentView.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 13/09/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Group {
                HomeViewBuilder.make()
                    .tabItem {
                        Label(InstaflixContants.Strings.home, systemImage: InstaflixContants.Icons.home)
                    }

                MyListViewBuilder.make()
                    .tabItem {
                        Label(InstaflixContants.Strings.myList, systemImage: InstaflixContants.Icons.myList)
                    }
            }
            .toolbarBackground(.ultraThinMaterial, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(BannerViewModel())
}
