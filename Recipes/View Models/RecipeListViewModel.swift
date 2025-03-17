//
//  RecipeListViewModel.swift
//  Recipes
//
//  Created by David Wright on 3/17/25.
//

import Foundation

struct RecipeListViewModel {

    private var recipes: [Recipe]

    init(recipes: [Recipe]) {
        self.recipes = recipes
    }
}

extension RecipeListViewModel {

    var recipeViewModels: [RecipeViewModel] {
        recipes.map { RecipeViewModel(recipe: $0) }
    }
}
