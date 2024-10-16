//
//  AppLaunchView.swift
//  fetch
//
//  Created by Arturo on 10/16/24.
//

import SwiftUI

struct AppLaunchView: View {
    
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Image(illustration: .logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                
                Spacer()
            }
        }
        .background(.white)
        .onAppear {
            
        }
    }
    
}

#Preview {
    AppLaunchView()
}
