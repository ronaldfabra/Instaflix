//
//  ShareButton.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import SwiftUI

struct ShareButton: View {

    var urlString: String

    var body: some View {
        if let url = URL(string: urlString) {
            ShareLink(item: url) {
                VStack(spacing: 8) {
                    Image(systemName: InstaflixContants.Icons.share)
                        .font(.title)

                    Text(InstaflixContants.Strings.share)
                        .font(.caption)
                }
                .padding(8)
                .background(Color.instaflixBlack.opacity(0.001))
            }
        }
    }
}

#Preview {
    ShareButton(urlString: "www.google.com")
}
