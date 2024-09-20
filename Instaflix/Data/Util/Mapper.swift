//
//  Mapper.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 14/09/24.
//

import Foundation

open class Mapper<T, U> {
    open func mapValue(response: T) -> U {
        fatalError("Subclasses need to implement the `mapValue` method.")
    }

    public final func mapList(response: [T]) -> [U] {
        return response.compactMap({ mapValue(response: $0 )})
    }

    public init() {}
}
