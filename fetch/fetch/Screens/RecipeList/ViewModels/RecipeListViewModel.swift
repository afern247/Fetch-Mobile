//
//  RecipeListViewModel.swift
//  fetch
//
//  Created by Arturo on 10/16/24.
//

import Foundation

enum Endpoints: String {
    case recipes, malformedData, emptyData
    
    var url: String {
        switch self {
        case .recipes: return "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
        case .malformedData: return "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
        case .emptyData: return "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
        }
    }
}

@Observable
class RecipeListViewModel {
    
    var recipes: [Recipe] = []
    var endpoint: Endpoints = .recipes
    var showErrorView = false
    var refreshRecipes = false
    
    private let recipeService: RecipeServiceProtocol
    
    init(recipeService: RecipeServiceProtocol = RecipeService(), recipes: [Recipe] = []) {
        self.recipeService = recipeService
        self.recipes = recipes
    }
    
    /// Fetches recipes from the specified endpoint asynchronously and updates the view model's state.
    /// - Parameter endpoint: The endpoint to fetch recipes from. Defaults to `.recipes`.
    ///
    /// Sample usage:
    /// ```swift
    /// await viewModel.fetchRecipes(for: .malformedData)
    /// ```
    func fetchRecipes(for endpoint: Endpoints = .recipes) async {
        if let fetchedRecipes = await recipeService.fetchRecipes(for: endpoint) {
            DispatchQueue.main.async { [weak self] in
                self?.recipes = fetchedRecipes
                self?.showErrorView = false
            }
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.showErrorView = true
            }
        }
    }
}
