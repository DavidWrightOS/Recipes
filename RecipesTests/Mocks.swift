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
