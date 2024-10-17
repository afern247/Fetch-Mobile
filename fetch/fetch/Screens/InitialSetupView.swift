//
//  InitialSetupView.swift
//  fetch
//
//  Created by Arturo on 10/16/24.
//

import SwiftUI

struct InitialSetupView: View {
    
    @State private var vm = RecipeListViewModel()
    
    @State private var isInitialSetupDone = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if isInitialSetupDone {
                    RecipesListView()
                } else {
                    AppLaunchView()
                        .transition(.opacity)
                }
            }
            .setBackgroundColor()
            .animation(.easeInOut, value: (isInitialSetupDone))
        }
        .environment(vm)
        .onChange(of: vm.refreshRecipes) { _, _ in
            refreshRecipes()
        }
    }
    
    private func refreshRecipes() {
        Task(priority: .userInitiated) {
            await vm.fetchRecipes(for: vm.endpoint)
            isInitialSetupDone = true
        }
    }
}

#Preview {
    InitialSetupView()
}
