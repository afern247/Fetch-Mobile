//
//  View+Background.swift
//  fetch
//
//  Created by Arturo on 10/16/24.
//

import SwiftUI

extension View {
    
    // Backgrounds
    func setBackgroundColor(color: Color? = nil, alignment: Alignment = .center, maxWidth: CGFloat = .infinity, maxHeight: CGFloat = .infinity) -> some View {
        modifier(ThemeBackgroundSolidColor(color: color, alignment: alignment, maxWidth: maxWidth, maxHeight: maxHeight))
    }
    
    // Card background
    func setCardBackgroundColor() -> some View {
        modifier(DefaultThemeBackgroundCardColor())
    }
}

// Backgrounds
struct ThemeBackgroundSolidColor: ViewModifier {
    
    let color: Color?
    let alignment: Alignment
    let maxWidth: CGFloat
    let maxHeight: CGFloat
    
    func body(content: Content) -> some View {
        content
            .frame(
                maxWidth: maxWidth,
                maxHeight: maxHeight,
                alignment: alignment
            )
            .background((color ?? Color.bgCommonElement).ignoresSafeArea(.all, edges: .all))
    }
}

// Card 2 background
struct DefaultThemeBackgroundCardColor: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.bgCommonElement.ignoresSafeArea(.all, edges: .all))
    }
}
