//
//  fetchTests.swift
//  fetchTests
//
//  Created by Arturo on 10/16/24.
//

import XCTest
@testable import fetch

final class fetchTests: XCTestCase {
    
    var viewModel: RecipeListViewModel!
    var mockService: MockRecipeService!
    
    override func setUpWithError() throws {
        mockService = MockRecipeService()
        viewModel = RecipeListViewModel(recipeService: mockService)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        mockService = nil
    }
    
    func testFetchRecipesSuccess() async throws {
        // Given
        mockService.mockResponse = mockRecipesResponse.recipes
        
        // When
        let expectation = XCTestExpectation(description: "Fetch recipes successfully")
        Task {
            await viewModel.fetchRecipes(for: .recipes)
            expectation.fulfill()
        }
        
        // Then
        await fulfillment(of: [expectation], timeout: 5.0)
        XCTAssertFalse(viewModel.showErrorView, "Error view should not be shown on success")
        XCTAssertEqual(viewModel.recipes.count, mockRecipesResponse.recipes.count, "Recipes count should match the mock response")
        XCTAssertEqual(viewModel.recipes.first?.name, "Apam Balik", "First recipe name should match the mock data")
    }
    
    func testFetchRecipesFailure() async throws {
        // Given
        mockService.mockResponse = nil
        
        // When
        let expectation = XCTestExpectation(description: "Fetch recipes failure")
        Task {
            await viewModel.fetchRecipes(for: .malformedData)
            expectation.fulfill()
        }
        
        // Then
        await fulfillment(of: [expectation], timeout: 5.0)
        XCTAssertTrue(viewModel.showErrorView, "Error view should be shown on failure")
        XCTAssertTrue(viewModel.recipes.isEmpty, "Recipes should be empty on failure")
    }
    
    func testFetchRecipesEmptyResponse() async throws {
        // Given
        mockService.mockResponse = []
        
        // When
        let expectation = XCTestExpectation(description: "Fetch recipes with empty response")
        Task {
            await viewModel.fetchRecipes(for: .emptyData)
            expectation.fulfill()
        }
        
        // Then
        await fulfillment(of: [expectation], timeout: 5.0)
        XCTAssertFalse(viewModel.showErrorView, "Error view should not be shown on empty response")
        XCTAssertTrue(viewModel.recipes.isEmpty, "Recipes should be empty when the response is empty")
    }
    
    func testFetchRecipesTimeout() async throws {
        // Given
        mockService.mockResponse = nil
        
        // Simulate a delay in the mock service
        mockService.delay = 4.0
        
        // When
        let expectation = XCTestExpectation(description: "Fetch recipes timeout")
        Task {
            await viewModel.fetchRecipes(for: .emptyData)
            expectation.fulfill()
        }
        
        // Then
        await fulfillment(of: [expectation], timeout: 5.0)
        XCTAssertTrue(viewModel.showErrorView, "Error view should be shown on timeout")
        XCTAssertTrue(viewModel.recipes.isEmpty, "Recipes should be empty on timeout")
    }
}

// Mock service to simulate network responses
class MockRecipeService: RecipeServiceProtocol {
    var mockResponse: [Recipe]?
    var delay: TimeInterval = 0.0 // To mock timeout
    
    func fetchRecipes(for endpoint: Endpoints) async -> [Recipe]? {
        if delay > 0 {
            try? await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
        }
        return mockResponse
    }
}
