//
//  MockApiService.swift
//  Recipes
//
//  Created by David Wright on 3/17/25.
//

struct MockApiService: ApiServiceProtocol {
    func fetchRecipes() async throws -> [Recipe] {
        try await Task.sleep(for: .seconds(2)) // delay response to simulate a network request
        return .mockRecipes
    }
}
