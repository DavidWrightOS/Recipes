//
//  EmptyListViewModel.swift
//  Recipes
//
//  Created by David Wright on 3/17/25.
//

struct EmptyListViewModel {

    enum RecipesResult {
        case noRecipes
        case error
    }

    private let recipesResult: RecipesResult?
    private let isLoading: Bool

    let retryButtonAction: () -> Void

    init(
        recipesResult: RecipesResult? = nil,
        isLoading: Bool = false,
        retryButtonAction: @escaping () -> Void = {}
    ) {
        self.recipesResult = recipesResult
        self.isLoading = isLoading
        self.retryButtonAction = retryButtonAction
    }
}

extension EmptyListViewModel {

    var title: String {
        switch recipesResult {
        case .none: return "Loading Recipes…"
        case .noRecipes: return "No Recipes"
        case .error: return "Cannot Load Recipes"
        }
    }

    var description: String {
        switch recipesResult {
        case .none: return ""
        case .noRecipes: return "There are no recipes to display."
        case .error: return "The recipes couldn't be loaded. Make sure you are connected to the internet and try again."
        }
    }

    var showLoadingIndicator: Bool {
        isLoading
    }

    var showRetryButton: Bool {
        recipesResult != nil
    }

    var retryButtonTitle: String {
        isLoading ? "Loading…" : "Retry"
    }

    var retryButtonDisabled: Bool {
        isLoading
    }
}

// Equatable conformance added for unit testing.
extension EmptyListViewModel: Equatable {
    static func == (lhs: EmptyListViewModel, rhs: EmptyListViewModel) -> Bool {
        lhs.recipesResult == rhs.recipesResult &&
        lhs.isLoading == rhs.isLoading
    }
}
