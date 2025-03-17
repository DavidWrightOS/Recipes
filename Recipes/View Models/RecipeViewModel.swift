//
//  RecipeViewModel.swift
//  Recipes
//
//  Created by David Wright on 3/17/25.
//

struct RecipeViewModel {

    private let recipe: Recipe

    init(recipe: Recipe) {
        self.recipe = recipe
    }
}

extension RecipeViewModel {

    var primaryText: String {
        recipe.name
    }

    var secondaryText: String {
        recipe.cuisine
    }
}

extension RecipeViewModel: Identifiable {

    var id: String {
        recipe.id
    }
}
