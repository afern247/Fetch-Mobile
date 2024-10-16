//
//  LoadingAnimation.swift
//  fetch
//
//  Created by Arturo on 10/16/24.
//

import SwiftUI

struct SpinnerImage: View {
    
    @ScaledMetric private var iconHeight: CGFloat
    
    private var isLoadingAnimation: Bool
    
    @State private var rotationAngle: Angle = .degrees(0)
    
    init(iconHeight: CGFloat = .spacing16, isLoadingAnimation: Bool = false) {
        self._iconHeight = ScaledMetric(wrappedValue: iconHeight, relativeTo: .largeTitle)
        self.isLoadingAnimation = isLoadingAnimation
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Image(illustration: .spinnerImage)
                .resizable()
                .frame(width: isLoadingAnimation ? (iconHeight + .spacing28) : iconHeight, height: isLoadingAnimation ? (iconHeight + .spacing28) : iconHeight)
                .rotationEffect(rotationAngle)
                .onAppear {
                    withAnimation(Animation.linear(duration: 1.0).repeatForever(autoreverses: false)) {
                        rotationAngle = .degrees(360)
                    }
                }
                .onDisappear {
                    rotationAngle = .degrees(0)
                }
        }
    }
}

struct LoadingAnimation: View {
    
    let minWidth: CGFloat = 120
    let maxWidth: CGFloat = 200
    let minHeight: CGFloat = 120
    let maxHeight: CGFloat = 180
    
    var body: some View {
        VStack(alignment: .center, spacing: .spacing4) {
            SpinnerImage(isLoadingAnimation: true)
        }
        .padding()
        .frame(minWidth: minWidth,
               maxWidth: minWidth,
               minHeight: minHeight,
               maxHeight: minHeight,
               alignment: .center
        )
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.bgCommonElement, Color.bgCommonElement.opacity(0.9)]), startPoint: .top, endPoint: .bottom)
        )
        .overlay(
            RoundedRectangle(cornerRadius: .spacing20)
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.fillButtonBorder.opacity(0.6), Color.fillButtonBorder.opacity(0.3)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                )
        )
        .cornerRadius(.spacing20)
        .elevation(.raised)
    }
}

#Preview {
    LoadingAnimation()
        .setBackgroundColor()
}
