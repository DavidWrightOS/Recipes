//
//  ImagePersistence.swift
//  Recipes
//
//  Created by David Wright on 3/18/25.
//

import UIKit

struct ImagePersistence: ImagePersistenceProtocol {

    func setImage(_ image: UIImage, for url: URL) {
        guard let fileUrl = fileUrl(for: url) else { return }
        guard let data = image.jpegData(compressionQuality: 1) else { return }
        try? data.write(to: fileUrl)
    }

    func getImage(for url: URL) -> UIImage? {
        guard let fileUrl = fileUrl(for: url) else { return nil }
        guard let data = try? Data(contentsOf: fileUrl) else { return nil }
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
