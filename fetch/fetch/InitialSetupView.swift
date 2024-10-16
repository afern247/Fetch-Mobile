//
//  InitialSetupView.swift
//  fetch
//
//  Created by Arturo on 10/16/24.
//

import SwiftUI

struct InitialSetupView: View {
    
    @State private var isInitialSetupDone = false
    @State private var isLoadingIndicatorActive = false
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack {
                    if isInitialSetupDone {
                        Text("Hello fetch")
                    } else {
                        AppLaunchView()
                            .transition(.opacity)
                    }
                }
                .animation(.easeInOut, value: (isInitialSetupDone))
            }
            
            if isLoadingIndicatorActive {
                LoadingAnimation()
            }
        }
    }
}

#Preview {
    InitialSetupView()
}
