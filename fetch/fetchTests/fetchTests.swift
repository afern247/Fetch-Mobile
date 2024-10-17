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
        // Initialize the mock service and view model before each test
        mockService = MockRecipeService()
        viewModel = RecipeListViewModel(recipeService: mockService)
    }

    override func tearDownWithError() throws {
        // Clean up after each test
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
        wait(for: [expectation], timeout: 5.0) // Timeout after 5 seconds
        XCTAssertFalse(viewModel.showErrorView, "Error view should not be shown on success")
        XCTAssertEqual(viewModel.recipes.count, mockRecipesResponse.recipes.count, "Recipes count should match the mock response")
        XCTAssertEqual(viewModel.recipes.first?.name, "Apam Balik", "First recipe name should match the mock data")
    }
    
    func testFetchRecipesFailure() async throws {
        // Given
        mockService.mockResponse = nil // Simulate failure
        
        // When
        let expectation = XCTestExpectation(description: "Fetch recipes failure")
        Task {
            await viewModel.fetchRecipes(for: .recipes)
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 5.0) // Timeout after 5 seconds
        XCTAssertTrue(viewModel.showErrorView, "Error view should be shown on failure")
        XCTAssertTrue(viewModel.recipes.isEmpty, "Recipes should be empty on failure")
    }
    
    func testRefreshRecipesToggle() {
        // Given
        XCTAssertFalse(viewModel.refreshRecipes, "Initial refreshRecipes should be false")
        
        // When
        viewModel.refreshRecipes.toggle()
        
        // Then
        XCTAssertTrue(viewModel.refreshRecipes, "refreshRecipes should toggle to true")
    }
    
    func testPerformanceFetchRecipes() throws {
        measure {
            let expectation = XCTestExpectation(description: "Performance test for fetchRecipes")
            Task {
                await viewModel.fetchRecipes(for: .recipes)
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 5.0) // Timeout after 5 seconds
        }
    }
}

// Mock service to simulate network responses
class MockRecipeService: RecipeServiceProtocol {
    var mockResponse: [Recipe]?
    
    func fetchRecipes(for endpoint: Endpoints) async -> [Recipe]? {
        return mockResponse
    }
}
