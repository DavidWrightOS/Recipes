//
//  RecipeListView.swift
//  Recipes
//
//  Created by David Wright on 3/17/25.
//

import SwiftUI

struct RecipeListView: View {

    let viewModel: RecipeListViewModel

    init(viewModel: RecipeListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.recipeViewModels) { recipeViewModel in
                    RecipeView(viewModel: recipeViewModel)
                }
            }
            .listStyle(.plain)
            .navigationBarTitle("Recipes")
        }
    }
}

#Preview {
    RecipeListView(
        viewModel: RecipeListViewModel(recipes: .mockRecipes)
    )
}

