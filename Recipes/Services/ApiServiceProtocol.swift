//
//  ApiServiceProtocol.swift
//  Recipes
//
//  Created by David Wright on 3/17/25.
//

protocol ApiServiceProtocol {
    func fetchRecipes() async throws -> [Recipe]
}
