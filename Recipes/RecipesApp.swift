//
//  RecipesApp.swift
//  Recipes
//
//  Created by David Wright on 3/17/25.
//

import SwiftUI

@main
struct RecipesApp: App {
    var body: some Scene {
        WindowGroup {
            RecipeListView(
                viewModel: RecipeListViewModel(recipes: .mockRecipes)
            )
        }
    }
}
