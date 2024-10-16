//
//  InitialSetupView.swift
//  fetch
//
//  Created by Arturo on 10/16/24.
//

import SwiftUI

struct InitialSetupView: View {
    
    // Once the backend has been setup and metadata checked
    @State private var isInitialSetupDone = false
    
    // Gloabl loading indicator to reuse on views
    @State private var loadingIndicatorIsActive = false
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack {
                    if isInitialSetupDone {
                        Text("hello world")
                            .typography(.title)
                    } else {
                        Text("hello world")
                            .typography(.bodyLarge)
                        //                    AppLaunchView(isInitialSetupDone: $isInitialSetupDone)
                            .transition(.opacity)
                    }
                }
                .animation(.easeInOut, value: (isInitialSetupDone))
            }
            
            if loadingIndicatorIsActive {
                LoadingAnimation()
            }
        }
    }
}

#Preview {
    InitialSetupView()
}
