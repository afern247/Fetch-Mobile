//
//  RecipeListView.swift
//  fetch
//
//  Created by Arturo on 10/16/24.
//

import SwiftUI

struct RecipesListView: View {
    
    @Environment(RecipeListViewModel.self) private var vm
    
    @State private var selectedCuisine: String = "All"
    
    private var filteredRecipes: [Recipe] {
        vm.filterRecipes(by: selectedCuisine)
    }
    
    var body: some View {
        Group {
            if vm.showErrorView {
                ContentUnavailableView(type: .error, title: "Error", message: "Failed to load recipes", buttonTitle: "Retry", onButtonTap: {
                    vm.refreshRecipes.toggle()
                })
            } else {
                VStack {
                    Picker("Select Endpoint", selection: Binding(get: {
                        vm.endpoint
                    }, set: { newValue in
                        vm.endpoint = newValue
                        vm.refreshRecipes.toggle()
                    })) {
                        Text("Recipes")
                            .tag(Endpoints.recipes)
                        Text("Malformed Data")
                            .tag(Endpoints.malformedData)
                        Text("Empty Data")
                            .tag(Endpoints.emptyData)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    HStack {
                        Spacer()
                        
                        // Cuisine Filter Picker
                        Picker("Select Cuisine", selection: $selectedCuisine) {
                            Text("All")
                                .tag("All")
                            ForEach(vm.getAvailableCuisines(), id: \.self) { cuisine in
                                Text(cuisine)
                                    .tag(cuisine)
                            }
                        }
                        .pickerStyle(.menu)
                        .padding(.horizontal)
                    }
                    
                    ScrollView(showsIndicators: false) {
                        if filteredRecipes.isEmpty {
                            ContentUnavailableView(image: "tray", title: "Empty", message: "There are no recipes available")
                                .padding(.top, .spacing24)
                        } else {
                            LazyVStack(spacing: .spacing24) {
                                ForEach(filteredRecipes, id: \.uuid) { recipe in
                                    recipeCard(recipe)
                                }
                            }
                            .padding([.horizontal, .top])
                        }
                    }
                    .refreshable {
                        vm.refreshRecipes.toggle()
                    }
                }
            }
        }
        .navigationBarTitle("Recipes", displayMode: .large)
    }
    
    @ViewBuilder
    private func recipeCard(_ recipe: Recipe) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            LoadImageFromUrl(urlString: (recipe.photoURLLarge.isEmptyOrWhiteSpace() ? recipe.photoURLSmall : recipe.photoURLLarge))
            
            Text(recipe.name)
                .typography(.headerLarge, textAlignment: .leading, color: .fillPrimary, multiline: true)
                .padding([.horizontal, .top])
            
            Text(recipe.cuisine)
                .typography(.bodyLarge, color: .fillSecondary)
                .padding(.horizontal)
            
            HStack(alignment: .bottom) {
                if let youtubeURL = URL(string: recipe.youtubeURL), !recipe.youtubeURL.isEmptyOrWhiteSpace() {
                    Link(destination: youtubeURL) {
                        HStack(spacing: .spacing4) {
                            Image(systemName: "play.circle.fill")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width: .spacing12, height: .spacing12)
                            
                            Text("Watch on YouTube")
                                .typography(.labelSmall, textAlignment: .leading, multiline: true)
                                .foregroundColor(.red)
                        }
                    }
                }
                
                Spacer()
                
                if let sourceURL = URL(string: recipe.sourceURL), !recipe.sourceURL.isEmptyOrWhiteSpace() {
                    Link(destination: sourceURL) {
                        Text("Source")
                            .typography(.caption)
                    }
                }
            }
            .padding()
        }
        .background(Color.bgPrimaryArea)
        .cornerRadius(.spacing20)
    }
}

#Preview {
    RecipesListView()
        .environment(RecipeListViewModel(recipes: mockRecipesResponse.recipes))
}
