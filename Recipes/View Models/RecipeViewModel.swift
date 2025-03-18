//
//  RecipeViewModel.swift
//  Recipes
//
//  Created by David Wright on 3/17/25.
//

import UIKit

@MainActor
class RecipeViewModel: ObservableObject, Identifiable {

    private let recipe: Recipe
    private let imageRepository: ImageRepositoryProtocol

    @Published var image: UIImage?
    @Published var isLoading: Bool = false

    init(
        recipe: Recipe,
        imageRepository: ImageRepositoryProtocol
    ) {
        self.recipe = recipe
        self.imageRepository = imageRepository
    }
}

extension RecipeViewModel {

    var primaryText: String {
        recipe.name
    }

    var secondaryText: String {
        recipe.cuisine
    }

    func loadImage() async {
        guard image == nil, let imageUrl else { return }

        isLoading = true

        image = try? await imageRepository.fetchImage(for: imageUrl)

        isLoading = false
    }

    func cancelLoadingImage() {
        guard isLoading, let imageUrl else { return }

        Task {
            await imageRepository.cancelFetchingImage(for: imageUrl)
            isLoading = false
        }
    }

    private var imageUrl: URL? {
        guard let urlString = recipe.photoUrlSmall else { return nil }
        return URL(string: urlString)
    }
}

// Equatable conformance added for unit testing.
extension RecipeViewModel: @preconcurrency Equatable {
    static func == (lhs: RecipeViewModel, rhs: RecipeViewModel) -> Bool {
        lhs.recipe == rhs.recipe &&
        lhs.imageRepository === rhs.imageRepository &&
        lhs.image == rhs.image &&
        lhs.isLoading == rhs.isLoading
    }
}
