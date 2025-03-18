//
//  RecipeViewModelTests.swift
//  RecipesTests
//
//  Created by David Wright on 3/17/25.
//

import XCTest
@testable import Recipes

@MainActor
final class RecipeViewModelTests: XCTestCase {

    func testBeforeLoadingImage() {
        let viewModel = RecipeViewModel(
            recipe: .mockRecipe1,
            imageRepository: MockImageRepository()
        )

        XCTAssertEqual(viewModel.primaryText, "Bakewell Tart")
        XCTAssertEqual(viewModel.secondaryText, "British")
        XCTAssertEqual(viewModel.image, nil)
        XCTAssertEqual(viewModel.isLoading, false)
    }

    func testLoadImageSuccess() async {
        let mockImageRepository = MockImageRepository(
            fetchImage: { url in
                XCTAssertEqual(url, URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/dd936646-8100-4a1c-b5ce-5f97adf30a42/small.jpg")!)
                return UIImage(systemName: "photo")!
            }
        )
        let viewModel = RecipeViewModel(recipe: .mockRecipe1, imageRepository: mockImageRepository)

        XCTAssertEqual(viewModel.primaryText, "Bakewell Tart")
        XCTAssertEqual(viewModel.secondaryText, "British")
        XCTAssertNil(viewModel.image)
        XCTAssertFalse(viewModel.isLoading)

        await viewModel.loadImage()

        XCTAssertNotNil(viewModel.image)
        XCTAssertEqual(viewModel.image, UIImage(systemName: "photo"))
        XCTAssertFalse(viewModel.isLoading)
    }

    func testLoadImageError() async {
        let mockImageRepository = MockImageRepository(
            fetchImage: { url in
                XCTAssertEqual(url, URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/dd936646-8100-4a1c-b5ce-5f97adf30a42/small.jpg")!)
                throw ImageRepositoryError.invalidImageData
            }
        )
        let viewModel = RecipeViewModel(recipe: .mockRecipe1, imageRepository: mockImageRepository)

        XCTAssertNil(viewModel.image)
        XCTAssertFalse(viewModel.isLoading)

        await viewModel.loadImage()

        XCTAssertNil(viewModel.image)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testLoadImageWithNoUrlDoesNotCallFetchImage() async {
        let mockImageRepository = MockImageRepository(
            fetchImage: { url in
                fatalError("ImageRepository.fetchImage(for:) should not be called for a recipe with no image url.")
            }
        )
        let viewModel = RecipeViewModel(recipe: .mockRecipeWithNoUrls, imageRepository: mockImageRepository)

        XCTAssertNil(viewModel.image)
        XCTAssertFalse(viewModel.isLoading)

        await viewModel.loadImage()

        XCTAssertNil(viewModel.image)
        XCTAssertFalse(viewModel.isLoading)
    }
}
