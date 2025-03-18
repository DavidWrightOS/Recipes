//
//  ImageCache.swift
//  Recipes
//
//  Created by David Wright on 3/18/25.
//

import UIKit

struct ImageCache: ImageCacheProtocol {

    private let imageCache = NSCache<NSURL, UIImage>()

    func getImage(for url: URL) -> UIImage? {
        imageCache.object(forKey: url as NSURL)
    }

    func setImage(_ image: UIImage, for url: URL) {
        imageCache.setObject(image, forKey: url as NSURL)
    }
}
