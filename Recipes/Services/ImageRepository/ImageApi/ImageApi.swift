//
//  ImageApi.swift
//  Recipes
//
//  Created by David Wright on 3/18/25.
//

import UIKit

struct ImageApi: ImageApiProtocol {

    func fetchImage(for url: URL) async throws -> UIImage {
        // Ignore URLSession caching to ensure reliance on our repository's custom caching implementation.
        let urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        guard let image = UIImage(data: data) else { throw ImageRepositoryError.invalidImageData }
        return image
    }
}
