//
//  RecipeService.swift
//  fetch
//
//  Created by Arturo on 10/16/24.
//

import Foundation

protocol RecipeServiceProtocol {
    func fetchRecipes(for endpoint: Endpoints) async -> [Recipe]?
}

class RecipeService: RecipeServiceProtocol {
    
    /// Fetches recipes from the specified endpoint asynchronously and decodes the response.
    /// - Parameter endpoint: The endpoint to fetch recipes from.
    /// - Returns: An optional array of `Recipe` objects, or `nil` if the fetch fails.
    ///
    /// Sample usage:
    /// ```swift
    /// let recipes = await recipeService.fetchRecipes(for: .recipes)
    /// ```
    func fetchRecipes(for endpoint: Endpoints) async -> [Recipe]? {
        guard let decodedResponse: RecipesResponse = await NetworkHandler.requestAndDecode(urlString: endpoint.url, method: .GET) else { return nil }
        return decodedResponse.recipes
    }
}
