//
//  ImageStoreTests.swift
//  RecipesTests
//
//  Created by David Wright on 3/18/25.
//

import XCTest
@testable import Recipes

final class ImageStoreTests: XCTestCase {

    // Test getting an image that has been cached.
    func testGetImageFromCache() {
        let mockImageCache = MockImageStore(
            getImage: { _ in .mockImage }
        )
        let imageStore = ImageStore(
            imageCache: mockImageCache,
            imagePersistence: MockImageStore()
        )

        let image = imageStore.getImage(for: .mockUrl)

        XCTAssertEqual(image, UIImage(systemName: "photo")!)
    }

    // Test getting an image that has been persisted to disk but is not in the cache (e.g. after re-launching the app).
    func testGetImageFromDiskSetsImageInCache() {
        var callsToSetImageInCache = [(image: UIImage, url: URL)]()
        let mockImageCache = MockImageStore(
            getImage: { _ in nil },
            setImage: { image, url in callsToSetImageInCache.append((image, url)) }
        )
        let mockImagePersistence = MockImageStore(
            getImage: { _ in .mockImage }
        )
        let imageStore = ImageStore(
            imageCache: mockImageCache,
            imagePersistence: mockImagePersistence
        )

        let image = imageStore.getImage(for: .mockUrl)
        XCTAssertEqual(image, UIImage(systemName: "photo")!)

        XCTAssertEqual(callsToSetImageInCache.count, 1)
        XCTAssertEqual(callsToSetImageInCache[0].image, UIImage(systemName: "photo")!)
        XCTAssertEqual(callsToSetImageInCache[0].url, URL(string: "https://example.com/image.jpg")!)
    }

    // Test setting an image should set it in both the cache and persistent stores.
    func testSetImageUpdatesCacheAndPersistenceStores() {
        var callsToSetImageInCache = [(image: UIImage, url: URL)]()
        var callsToSetImageInPersistence = [(image: UIImage, url: URL)]()
        let mockImageCache = MockImageStore(
            setImage: { image, url in
                callsToSetImageInCache.append((image, url))
            }
        )
        let mockImagePersistence = MockImageStore(
            setImage: { image, url in
                callsToSetImageInPersistence.append((image, url))
            }
        )
        let imageStore = ImageStore(
            imageCache: mockImageCache,
            imagePersistence: mockImagePersistence
        )

        imageStore.setImage(.mockImage, for: .mockUrl)

        XCTAssertEqual(callsToSetImageInCache.count, 1)
        XCTAssertEqual(callsToSetImageInCache[0].image, UIImage(systemName: "photo")!)
        XCTAssertEqual(callsToSetImageInCache[0].url, URL(string: "https://example.com/image.jpg")!)

        XCTAssertEqual(callsToSetImageInPersistence.count, 1)
        XCTAssertEqual(callsToSetImageInPersistence[0].image, UIImage(systemName: "photo")!)
        XCTAssertEqual(callsToSetImageInPersistence[0].url, URL(string: "https://example.com/image.jpg")!)
    }
}
