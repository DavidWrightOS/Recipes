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

    /// Fetches an image from a URL, caches it, and returns it as a `UIImage`.
    public func fetchImage(for url: URL) async throws -> UIImage {

        // If there is an image cached for this URL, return the cached image.
        if let image = cachedImage(for: url) {
            return image
        }

        // If there is an image stored on disk for this URL, cache the image and return it.
        if let image = try? self.imageFromFileSystem(for: url) {
            cache(image, for: url)
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

            // Attempt to persist the image to disk.
            // Note: If persistence fails, do not throw an error, we still want to return the image.
            try? persistImage(image, for: url)

            return image
        }

        tasks[url] = task

        do {
            let image = try await task.value
            cache(image, for: url)
            tasks.removeValue(forKey: url)
            return image
        } catch {
            tasks.removeValue(forKey: url)
            throw error
        }
    }

    func cancelFetchingImage(for url: URL) {
        tasks.removeValue(forKey: url)?.cancel()
    }
}

extension ImageRepository {

    private func cachedImage(for url: URL) -> UIImage? {
        imageCache.object(forKey: url as NSURL)
    }

    private func cache(_ image: UIImage, for url: URL) {
        imageCache.setObject(image, forKey: url as NSURL)
    }

    /// Stores the given `UIImage` as JPEG data in the device's caches directory.
    private func persistImage(_ image: UIImage, for url: URL) throws {
        guard
            let fileUrl = fileUrl(for: url),
            let data = image.jpegData(compressionQuality: 1)
        else {
            assertionFailure("Unable to generate a local path for \(url)")
            return
        }

        try data.write(to: fileUrl)
    }

    /// Gets the JPEG data from the caches directory, if it exists, for the given web URL. Returns the image data as a `UIImage`.
    private func imageFromFileSystem(for url: URL) throws -> UIImage? {
        guard let fileUrl = fileUrl(for: url) else {
            assertionFailure("Unable to generate a local path for \(url)")
            return nil
        }

        let data = try Data(contentsOf: fileUrl)
        return UIImage(data: data)
    }

    /// Returns a file URL which is unique to the given web URL.
    private func fileUrl(for url: URL) -> URL? {
        FileManager.default
            // Persist images to cachesDirectory to allow stored images to be released if the device is low on memory.
            .urls(for: .cachesDirectory, in: .userDomainMask).first?
            // Use the hashed URL as the file name, to ensure the name is unique to the URL.
            // We can't use the URL string itself since it may contain special characters not permitted in file names.
            .appendingPathComponent(url.md5Hash)
            .appendingPathExtension("jpg")
    }
}
