//
//  ImageRepositoryProtocol.swift
//  Recipes
//
//  Created by David Wright on 3/17/25.
//

import UIKit

protocol ImageRepositoryProtocol: Actor {
    func fetch(_ url: URL) async throws -> UIImage
}
