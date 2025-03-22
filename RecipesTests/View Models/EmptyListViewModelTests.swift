//
//  EmptyListViewModelTests.swift
//  RecipesTests
//
//  Created by David Wright on 3/17/25.
//

import XCTest
@testable import Recipes

final class EmptyListViewModelTests: XCTestCase {

    func testLoadingRecipesForTheFirstTime() {
        let viewModel = EmptyListViewModel(
            recipesResult: nil,
            isLoading: true
        )
        XCTAssertEqual(viewModel.title, "Loading Recipes…")
        XCTAssertEqual(viewModel.description, "")
        XCTAssertEqual(viewModel.retryButtonTitle, "Loading…")
        XCTAssertTrue(viewModel.showLoadingIndicator)
        XCTAssertFalse(viewModel.showRetryButton)
        XCTAssertTrue(viewModel.retryButtonDisabled)
    }

    func testLoadRecipesError() {
        let viewModel = EmptyListViewModel(
            recipesResult: .error,
            isLoading: false
        )
        XCTAssertEqual(viewModel.title, "Cannot Load Recipes")
        XCTAssertEqual(viewModel.description, "The recipes couldn't be loaded. Make sure you are connected to the internet and try again.")
        XCTAssertEqual(viewModel.retryButtonTitle, "Retry")
        XCTAssertFalse(viewModel.showLoadingIndicator)
        XCTAssertTrue(viewModel.showRetryButton)
        XCTAssertFalse(viewModel.retryButtonDisabled)
    }

    func testLoadingRecipesAfterReceivingLoadRecipesError() {
        let viewModel = EmptyListViewModel(
            recipesResult: .error,
            isLoading: true
        )
        XCTAssertEqual(viewModel.title, "Cannot Load Recipes")
        XCTAssertEqual(viewModel.description, "The recipes couldn't be loaded. Make sure you are connected to the internet and try again.")
        XCTAssertEqual(viewModel.retryButtonTitle, "Loading…")
        XCTAssertTrue(viewModel.showLoadingIndicator)
        XCTAssertTrue(viewModel.showRetryButton)
        XCTAssertTrue(viewModel.retryButtonDisabled)
    }

    func testNoRecipes() {
        let viewModel = EmptyListViewModel(
            recipesResult: .noRecipes,
            isLoading: false
        )
        XCTAssertEqual(viewModel.title, "No Recipes")
        XCTAssertEqual(viewModel.description, "There are no recipes to display.")
        XCTAssertEqual(viewModel.retryButtonTitle, "Retry")
        XCTAssertFalse(viewModel.showLoadingIndicator)
        XCTAssertTrue(viewModel.showRetryButton)
        XCTAssertFalse(viewModel.retryButtonDisabled)
    }

    func testLoadingRecipesAfterReceivingNoRecipes() {
        let viewModel = EmptyListViewModel(
            recipesResult: .noRecipes,
            isLoading: true
        )
        XCTAssertEqual(viewModel.title, "No Recipes")
        XCTAssertEqual(viewModel.description, "There are no recipes to display.")
        XCTAssertEqual(viewModel.retryButtonTitle, "Loading…")
        XCTAssertTrue(viewModel.showLoadingIndicator)
        XCTAssertTrue(viewModel.showRetryButton)
        XCTAssertTrue(viewModel.retryButtonDisabled)
    }
}
