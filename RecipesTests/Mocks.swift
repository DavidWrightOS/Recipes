//
//  Mocks.swift
//  RecipesTests
//
//  Created by David Wright on 3/17/25.
//

import UIKit
@testable import Recipes

class MockApiService: ApiServiceProtocol {

    var _fetchRecipes: () async throws -> [Recipe]

    init(
        fetchRecipes: @escaping () async throws -> [Recipe] = { .mockRecipes }
    ) {
        self._fetchRecipes = fetchRecipes
    }

    func fetchRecipes() async throws -> [Recipe] {
        try await _fetchRecipes()
    }
}

actor MockImageRepository: ImageRepositoryProtocol {

    var _fetchImage: (URL) async throws -> UIImage
    var _cancelFetchingImage: (URL) -> Void

    init(
        fetchImage: @escaping (URL) async throws -> UIImage = { _ in fatalError("Unimplemented: MockImageRepository.fetchImage(for:)") },
        cancelFetchingImage: @escaping (URL) -> Void = { _ in fatalError("Unimplemented: MockImageRepository.cancelFetchingImage(for:)") }
    ) {
        self._fetchImage = fetchImage
        self._cancelFetchingImage = cancelFetchingImage
    }

    func fetchImage(for url: URL) async throws -> UIImage {
        try await _fetchImage(url)
    }

    func cancelFetchingImage(for url: URL) {
        _cancelFetchingImage(url)
    }
}

struct MockImageApi: ImageApiProtocol {

    var _fetchImage: (URL) async throws -> UIImage

    init(
        fetchImage: @escaping (URL) async throws -> UIImage = { _ in fatalError("Unimplemented: MockImageApi.fetchImage(for:)") }
    ) {
        _fetchImage = fetchImage
    }

    func fetchImage(for url: URL) async throws -> UIImage {
        try await _fetchImage(url)
    }
}

/// Can be used as a mock for `ImageCache` and/or `ImagePersistence`.
class MockImageStore: ImageCacheProtocol, ImagePersistenceProtocol {

    var _getImage: (URL) -> UIImage?
    var _setImage: (UIImage, URL) -> Void

    init(
        getImage: @escaping (URL) -> UIImage? = { _ in fatalError("Unimplemented: MockImageStore.getImage(for:)") },
        setImage: @escaping (UIImage, URL) -> Void = { _, _ in fatalError("Unimplemented: MockImageStore.setImage(_:for:)") }
    ) {
        _getImage = getImage
        _setImage = setImage
    }

    func getImage(for url: URL) -> UIImage? {
        _getImage(url)
    }

    func setImage(_ image: UIImage, for url: URL) {
        _setImage(image, url)
    }
}

extension Recipe {

    static let mockRecipe1 = Recipe(
        id: "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
        cuisine: "British",
        name: "Bakewell Tart",
        photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/dd936646-8100-4a1c-b5ce-5f97adf30a42/large.jpg",
        photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/dd936646-8100-4a1c-b5ce-5f97adf30a42/small.jpg",
        sourceUrl: nil,
        youtubeUrl: "https://www.youtube.com/watch?v=1ahpSTf_Pvk"
    )

    static let mockRecipe2 = Recipe(
        id: "f8b20884-1e54-4e72-a417-dabbc8d91f12",
        cuisine: "American",
        name: "Banana Pancakes",
        photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/large.jpg",
        photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg",
        sourceUrl: "https://www.bbcgoodfood.com/recipes/banana-pancakes",
        youtubeUrl: "https://www.youtube.com/watch?v=kSKtb2Sv-_U"
    )

    static let mockRecipeWithNoUrls = Recipe(
        id: "7e9fc2d3-9759-46ee-976e-d6ca0f682091",
        cuisine: "French",
        name: "Chocolate Gateau",
        photoUrlLarge: nil,
        photoUrlSmall: nil,
        sourceUrl: nil,
        youtubeUrl: nil
    )
}

extension Array<Recipe> {
    static let mockRecipes: [Recipe] = [.mockRecipe1, .mockRecipe2]
}

extension URL {
    static let mockUrl = URL(string: "https://example.com/image.jpg")!
}

extension UIImage {
    static let mockImage = UIImage(systemName: "photo")!
}
