//
//  RecipeListView.swift
//  Recipes
//
//  Created by David Wright on 3/17/25.
//

import SwiftUI

struct RecipeListView: View {

    @ObservedObject private var viewModel: RecipeListViewModel

    init(viewModel: RecipeListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            Group {
                if let emptyListViewModel = viewModel.emptyListViewModel {
                    EmptyListView(viewModel: emptyListViewModel)
                } else {
                    List {
                        ForEach(viewModel.recipeViewModels) { recipeViewModel in
                            RecipeView(viewModel: recipeViewModel)
                        }
                    }
                    .refreshable {
                        await viewModel.loadRecipes()
                    }
                    .listStyle(.plain)
                }
            }
            .navigationBarTitle("Recipes")
            .toolbarTitleDisplayMode(.inline)
        }
        .task {
            await viewModel.loadRecipes()
        }
    }
}

#Preview {
    RecipeListView(
        viewModel: RecipeListViewModel(
            apiService: MockApiService(),
            imageRepository: ImageRepository.shared
        )
    )
}

