//
//  RecipeView.swift
//  Recipes
//
//  Created by David Wright on 3/17/25.
//

import SwiftUI

struct RecipeView: View {

    let viewModel: RecipeViewModel

    init(viewModel: RecipeViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        HStack(spacing: 12) {
            Color.primary.opacity(0.1)
                .frame(width: 60, height: 60)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)

            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.primaryText)

                Text(viewModel.secondaryText)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
    }
}

#Preview {
    RecipeListView(
        viewModel: RecipeListViewModel(recipes: .mockRecipes)
    )
}
