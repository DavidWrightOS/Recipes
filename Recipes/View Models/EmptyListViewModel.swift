//
//  EmptyListViewModel.swift
//  Recipes
//
//  Created by David Wright on 3/17/25.
//

protocol EmptyListViewModelDelegate: AnyObject {
    func didTapRetry()
}

struct EmptyListViewModel {

    enum RecipesResult {
        case noRecipes
        case error
    }

    private let recipesResult: RecipesResult?
    private let isLoading: Bool
    private weak var delegate: EmptyListViewModelDelegate?

    init(
        recipesResult: RecipesResult? = nil,
        isLoading: Bool = false,
        delegate: EmptyListViewModelDelegate? = nil
    ) {
        self.recipesResult = recipesResult
        self.isLoading = isLoading
        self.delegate = delegate
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

    func didTapRetry() {
        delegate?.didTapRetry()
    }
}

// Equatable conformance added for unit testing.
extension EmptyListViewModel: Equatable {
    static func == (lhs: EmptyListViewModel, rhs: EmptyListViewModel) -> Bool {
        lhs.recipesResult == rhs.recipesResult &&
        lhs.isLoading == rhs.isLoading &&
        lhs.delegate === rhs.delegate
    }
}
