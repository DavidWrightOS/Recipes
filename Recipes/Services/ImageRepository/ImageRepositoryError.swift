//
//  ImageRepositoryError.swift
//  Recipes
//
//  Created by David Wright on 3/17/25.
//

import Foundation

enum ImageRepositoryError: Error {
    /// Unable to convert the downloaded data to a `UIImage`.
    case invalidImageData
}
