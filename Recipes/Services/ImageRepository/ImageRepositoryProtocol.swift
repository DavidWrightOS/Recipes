//
//  ImageRepositoryProtocol.swift
//  Recipes
//
//  Created by David Wright on 3/17/25.
//

import UIKit

protocol ImageRepositoryProtocol: Actor {
    func fetchImage(_ url: URL) async throws -> UIImage
    func cancelFetchingImage(for url: URL)
}
