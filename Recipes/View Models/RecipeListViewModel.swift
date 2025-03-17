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

    @Published private var recipes: [Recipe] = []

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
        recipes.map { RecipeViewModel(recipe: $0, imageRepository: imageRepository) }
    }

    func loadRecipes() async {
        do {
            recipes = try await apiService.fetchRecipes()
        } catch {
            recipes = []
        }
    }
}
