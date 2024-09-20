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
                        Label("Home", systemImage: "house")
                    }

                MyListViewBuilder.make()
                    .tabItem {
                        Label("My List", systemImage: "list.bullet")
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
}
