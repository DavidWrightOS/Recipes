//
//  ImageRepositoryTests.swift
//  RecipesTests
//
//  Created by David Wright on 3/18/25.
//

import XCTest
@testable import Recipes

final class ImageRepositoryTests: XCTestCase {

    func testFetchImageFromStore() async throws {
        let mockImageStore = MockImageStore(
            getImage: { _ in .mockImage }
        )
        let imageRepository = ImageRepository(
            imageApi: MockImageApi(),
            imageStore: mockImageStore
        )

        let image = try await imageRepository.fetchImage(for: .mockUrl)

        XCTAssertEqual(image, UIImage(systemName: "photo")!)
    }

    func testFetchImageFromApiSuccess() async throws {
        var callsToSetImageInStore = [(image: UIImage, url: URL)]()
        let mockImageApi = MockImageApi(
            fetchImage: { _ in .mockImage }
        )
        let mockImageStore = MockImageStore(
            getImage: { _ in nil },
            setImage: { image, url in callsToSetImageInStore.append((image, url)) }
        )
        let imageRepository = ImageRepository(
            imageApi: mockImageApi,
            imageStore: mockImageStore
        )

        XCTAssertEqual(callsToSetImageInStore.count, 0)

        let image = try await imageRepository.fetchImage(for: .mockUrl)

        XCTAssertEqual(image, UIImage(systemName: "photo")!)

        XCTAssertEqual(callsToSetImageInStore.count, 1)
        XCTAssertEqual(callsToSetImageInStore[0].image, UIImage(systemName: "photo")!)
        XCTAssertEqual(callsToSetImageInStore[0].url, URL(string: "https://example.com/image.jpg")!)
    }

    func testFetchImageFromApiError() async throws {
        let mockImageApi = MockImageApi(
            fetchImage: { _ in throw URLError(.badServerResponse) }
        )
        let mockImageStore = MockImageStore(
            getImage: { _ in nil }
        )
        let imageRepository = ImageRepository(
            imageApi: mockImageApi,
            imageStore: mockImageStore
        )

        do {
            let _ = try await imageRepository.fetchImage(for: .mockUrl)
            XCTFail("Expected call to ImageRepository.fetchImage(for:) to throw an error, but no error was thrown.")
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }
}
