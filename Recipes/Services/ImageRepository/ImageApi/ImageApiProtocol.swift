//
//  ImageApiProtocol.swift
//  Recipes
//
//  Created by David Wright on 3/18/25.
//

import UIKit

protocol ImageApiProtocol {
    func fetchImage(for url: URL) async throws -> UIImage
}
