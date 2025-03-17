//
//  RecipeListViewModel.swift
//  Recipes
//
//  Created by David Wright on 3/17/25.
//

import Foundation

class RecipeListViewModel: ObservableObject {

    private let apiService: ApiServiceProtocol

    @Published private var recipes: [Recipe] = []

    init(apiService: ApiServiceProtocol) {
        self.apiService = apiService
    }
}

extension RecipeListViewModel {

    var recipeViewModels: [RecipeViewModel] {
        recipes.map { RecipeViewModel(recipe: $0) }
    }

    @MainActor
    func loadRecipes() async {
        do {
            recipes = try await apiService.fetchRecipes()
        } catch {
            recipes = []
        }
    }
}
