//
//  ApiServiceError.swift
//  Recipes
//
//  Created by David Wright on 3/17/25.
//

enum ApiServiceError: Error {
    case invalidServerResponse
    case decodingError(Error?)
}
