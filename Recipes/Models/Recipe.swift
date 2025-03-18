//
//  Recipe.swift
//  Recipes
//
//  Created by David Wright on 3/17/25.
//

struct Recipe: Decodable  {

    /// The unique identifier for the receipe. Represented as a UUID.
    let id: String

    /// The cuisine of the recipe.
    let cuisine: String

    /// The name of the recipe.
    let name: String

    /// The URL of the recipes’s full-size photo.
    let photoUrlLarge: String?

    /// The URL of the recipes’s small photo. Useful for list view.
    let photoUrlSmall: String?

    /// The URL of the recipe's original website.
    let sourceUrl: String?

    /// The URL of the recipe's YouTube video.
    let youtubeUrl: String?
}

extension Recipe {

    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case cuisine
        case name

        case photoUrlLarge = "photo_url_large"
        case photoUrlSmall = "photo_url_small"

        case sourceUrl = "source_url"
        case youtubeUrl = "youtube_url"
    }
}

struct RecipesResponseData: Decodable {
    let recipes: [Recipe]
}

// Equatable conformance added for unit testing.
extension Recipe: Equatable {}
