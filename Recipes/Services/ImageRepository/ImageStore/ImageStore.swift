//
//  ImageStore.swift
//  Recipes
//
//  Created by David Wright on 3/18/25.
//

import UIKit

struct ImageStore: ImageStoreProtocol {

    private let imageCache: ImageCacheProtocol
    private let imagePersistence: ImagePersistenceProtocol

    init(
        imageCache: ImageCacheProtocol,
        imagePersistence: ImagePersistenceProtocol
    ) {
        self.imageCache = imageCache
        self.imagePersistence = imagePersistence
    }

    func getImage(for url: URL) -> UIImage? {

        // If there is an image cached for this URL, return the cached image.
        if let image = imageCache.getImage(for: url) {
            return image
        }

        // If there is an image stored on disk for this URL, add the image to the cache and return it.
        if let image = imagePersistence.getImage(for: url) {
            imageCache.setImage(image, for: url)
            return image
        }

        return nil
    }

    func setImage(_ image: UIImage, for url: URL) {
        imageCache.setImage(image, for: url)
        imagePersistence.setImage(image, for: url)
    }
}
