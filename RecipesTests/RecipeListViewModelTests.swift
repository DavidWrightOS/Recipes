//
//  RecipeListViewModelTests.swift
//  RecipesTests
//
//  Created by David Wright on 3/17/25.
//

import XCTest
@testable import Recipes

@MainActor
final class RecipeListViewModelTests: XCTestCase {

    func testLoadRecipesSuccess() async {
        let mockImageRepository = MockImageRepository()
        let viewModel = RecipeListViewModel(
            apiService: MockApiService(fetchRecipes: { [.mockRecipe1, .mockRecipe2] }),
            imageRepository: mockImageRepository
        )

        XCTAssertEqual(viewModel.recipeViewModels, [])

        await viewModel.loadRecipes()

        let expectedRecipeViewModels: [RecipeViewModel] = [
            RecipeViewModel(recipe: .mockRecipe1, imageRepository: mockImageRepository),
            RecipeViewModel(recipe: .mockRecipe2, imageRepository: mockImageRepository)
        ]
        XCTAssertEqual(viewModel.recipeViewModels, expectedRecipeViewModels)

        XCTAssertNil(viewModel.emptyListViewModel)
    }

    func testLoadRecipesEmptyResponse() async {
        let viewModel = RecipeListViewModel(
            apiService: MockApiService(fetchRecipes: { [] }),
            imageRepository: MockImageRepository()
        )

        await viewModel.loadRecipes()

        XCTAssertEqual(viewModel.recipeViewModels, [])

        let expectedEmptyListViewModel = EmptyListViewModel(
            recipesResult: .noRecipes,
            isLoading: false,
            delegate: viewModel
        )
        XCTAssertEqual(viewModel.emptyListViewModel, expectedEmptyListViewModel)
    }

    func testLoadRecipesError() async {
        let viewModel = RecipeListViewModel(
            apiService: MockApiService(fetchRecipes: { throw URLError(.badServerResponse) }),
            imageRepository: MockImageRepository()
        )

        await viewModel.loadRecipes()

        XCTAssertEqual(viewModel.recipeViewModels, [])

        let expectedEmptyListViewModel = EmptyListViewModel(
            recipesResult: .error,
            isLoading: false,
            delegate: viewModel
        )
        XCTAssertEqual(viewModel.emptyListViewModel, expectedEmptyListViewModel)
    }

    func testloadRecipesTriggersFetchRecipes() async {
        let expectation = XCTestExpectation(description: "loadRecipes() triggers fetch recipes.")
        let mockApiService = MockApiService(
            fetchRecipes: {
                expectation.fulfill()
                return []
            }
        )
        let viewModel = RecipeListViewModel(
            apiService: mockApiService,
            imageRepository: MockImageRepository()
        )

        await viewModel.loadRecipes()

        await fulfillment(of: [expectation], timeout: 10.0)
    }

    func testRetryButtonTriggersFetchRecipes() async {
        let expectation = XCTestExpectation(description: "Retry button triggers fetch recipes.")
        let mockApiService = MockApiService(
            fetchRecipes: {
                expectation.fulfill()
                return []
            }
        )
        let viewModel = RecipeListViewModel(
            apiService: mockApiService,
            imageRepository: MockImageRepository()
        )

        viewModel.didTapRetry()

        await fulfillment(of: [expectation], timeout: 10.0)
    }
}
