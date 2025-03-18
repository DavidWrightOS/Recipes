//
//  ImageRepository.swift
//  Recipes
//
//  Created by David Wright on 3/17/25.
//

import UIKit

actor ImageRepository: ImageRepositoryProtocol {

    private let imageApi: ImageApiProtocol
    private let imageStore: ImageStoreProtocol

    private var tasks = [URL: Task<UIImage, Error>]()

    init(
        imageApi: ImageApiProtocol,
        imageStore: ImageStoreProtocol
    ) {
        self.imageApi = imageApi
        self.imageStore = imageStore
    }

    /// Fetches an image from a URL, caches it, and returns it as a `UIImage`.
    func fetchImage(for url: URL) async throws -> UIImage {

        // If there is an image stored locally for this URL, return the image.
        if let image = imageStore.getImage(for: url) {
            return image
        }

        // If an image is currently being fetched for this URL, await the result. (This prevents duplicate requests)
        if let task = tasks[url] {
            return try await task.value
        }

        // Fetch the image for this URL.
        return try await fetchImageFromApiAndAddToLocalStores(url: url)
    }

    func cancelFetchingImage(for url: URL) {
        tasks.removeValue(forKey: url)?.cancel()
    }
}

extension ImageRepository {

    private func fetchImageFromApiAndAddToLocalStores(url: URL) async throws -> UIImage {
        let task = Task<UIImage, Error> {
            try await imageApi.fetchImage(for: url)
        }

        tasks[url] = task

        do {
            let image = try await task.value
            imageStore.setImage(image, for: url)
            tasks.removeValue(forKey: url)
            return image

        } catch {
            tasks.removeValue(forKey: url)
            throw error
        }
    }
}
