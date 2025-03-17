//
//  ImageRepository.swift
//  Recipes
//
//  Created by David Wright on 3/17/25.
//

import UIKit

actor ImageRepository: ImageRepositoryProtocol {

    // Make this a singleton to ensure there is only one image repository being used anywhere in the app.
    public static let shared = ImageRepository()

    private init() {}

    private var tasks = [URL: Task<UIImage, Error>]()
    private let imageCache = NSCache<NSURL, UIImage>()

    private func cachedImage(for url: URL) -> UIImage? {
        imageCache.object(forKey: url as NSURL)
    }

    private func cache(_ image: UIImage, for url: URL) {
        imageCache.setObject(image, forKey: url as NSURL)
    }


    /// Fetches an image from a URL, caches it, and returns it as a `UIImage`.
    public func fetch(_ url: URL) async throws -> UIImage {

        // If there is an image cached for this URL, return the cached image.
        if let image = cachedImage(for: url) {
            return image
        }

        // If an image is currently being fetched for this URL, await the result. (This prevents duplicate requests)
        if let task = tasks[url] {
            return try await task.value
        }

        // Fetch the image for this URL.
        // Ignore URLSession caching to ensure reliance on our repository's custom caching implementation.
        let urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)

        let task = Task<UIImage, Error> {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            guard let image = UIImage(data: data) else { throw ImageRepositoryError.invalidImageData }
            return image
        }

        tasks[url] = task

        let image = try await task.value

        cache(image, for: url)
        tasks.removeValue(forKey: url)

        return image
    }
}
