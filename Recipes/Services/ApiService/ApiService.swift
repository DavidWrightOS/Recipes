//
//  ApiService.swift
//  Recipes
//
//  Created by David Wright on 3/17/25.
//

import Foundation

struct ApiService: ApiServiceProtocol {

    func fetchRecipes() async throws -> [Recipe] {
        // Prevent URLSession caching. This ensures the data will be re-fetched whenever a refresh is triggered.
        let request = URLRequest(url: .allRecipes, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ApiServiceError.invalidServerResponse
        }

        do {
            return try JSONDecoder().decode(RecipesResponseData.self, from: data).recipes
        } catch {
            throw ApiServiceError.decodingError(error)
        }
    }
}

fileprivate extension URL {
    static let allRecipes: URL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
}
