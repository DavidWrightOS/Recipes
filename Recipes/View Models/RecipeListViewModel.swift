//
//  RecipeListViewModel.swift
//  Recipes
//
//  Created by David Wright on 3/17/25.
//

import Foundation

@MainActor
class RecipeListViewModel: ObservableObject {

    private let apiService: ApiServiceProtocol
    private let imageRepository: ImageRepositoryProtocol

    @Published private var recipesResult: Result<[Recipe], Error>?
    @Published private var isLoading: Bool = false

    init(
        apiService: ApiServiceProtocol,
        imageRepository: ImageRepositoryProtocol
    ) {
        self.apiService = apiService
        self.imageRepository = imageRepository
    }
}

extension RecipeListViewModel {

    var recipeViewModels: [RecipeViewModel] {
        guard let recipes = try? recipesResult?.get() else { return [] }
        return recipes.map { RecipeViewModel(recipe: $0, imageRepository: imageRepository) }
    }

    var emptyListViewModel: EmptyListViewModel? {
        let emptyListRecipesResult: EmptyListViewModel.RecipesResult?

        switch recipesResult {
        case .success(let recipes):
            guard recipes.isEmpty else { return nil }
            emptyListRecipesResult = .noRecipes
        case .failure:
            emptyListRecipesResult = .error
        case .none:
            emptyListRecipesResult = nil
        }

        return EmptyListViewModel(
            recipesResult: emptyListRecipesResult,
            isLoading: isLoading,
            delegate: self
        )
    }

    func loadRecipes() async {

        isLoading = true

        do {
            let recipes = try await apiService.fetchRecipes()
            recipesResult = .success(recipes)
        } catch {
            recipesResult = .failure(error)
        }

        isLoading = false
    }
}

extension RecipeListViewModel: EmptyListViewModelDelegate {

    nonisolated func didTapRetry() {
        Task { @MainActor in
            await loadRecipes()
        }
    }
}
