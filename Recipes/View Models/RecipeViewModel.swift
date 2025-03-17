//
//  RecipeViewModel.swift
//  Recipes
//
//  Created by David Wright on 3/17/25.
//

import UIKit

class RecipeViewModel: ObservableObject, Identifiable {

    private let recipe: Recipe
    private let imageRepository: ImageRepositoryProtocol

    @Published var imageResult: Result<UIImage, Error>?

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

    var hasImageUrl: Bool {
        imageUrl != nil
    }

    private var imageUrl: URL? {
        guard let urlString = recipe.photoUrlSmall else { return nil }
        return URL(string: urlString)
    }

    @MainActor
    func loadImage() async {

        imageResult = nil

        guard let imageUrl else { return }

        do {
            let image = try await imageRepository.fetch(imageUrl)
            imageResult = .success(image)
        } catch {
            imageResult = .failure(error)
        }
    }
}
