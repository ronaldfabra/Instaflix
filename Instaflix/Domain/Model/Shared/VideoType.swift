//
//  VideoType.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 17/09/24.
//

import Foundation

enum VideoType: String, Codable {
    case trailer = "Trailer"
    case teaser = "Teaser"
    case featurette = "Featurette"
    case behindTheScenes = "Behind the Scenes"
}
