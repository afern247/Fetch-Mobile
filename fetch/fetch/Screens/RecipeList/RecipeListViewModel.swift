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
    
    init(recipes: [Recipe] = []) {
        self.recipes = recipes
    }
    
    func fetchRecipes(for endpoint: Endpoints = .recipes) async -> [Recipe]? {
        guard let decodedResponse: RecipesResponse = await NetworkHandler.requestAndDecode(urlString: endpoint.url, method: .GET) else { return nil }
        
        DispatchQueue.main.async {
            self.recipes = decodedResponse.recipes
        }
        
        return decodedResponse.recipes
    }
}
