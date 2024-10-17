//
//  Elevation+SwiftUI.swift
//  fetch
//
//  Created by Arturo on 10/16/24.
//

import SwiftUI

/// Tokens that describe the shadows applied to a view to give it an elevated look.
public enum Elevation: CaseIterable {
    /// `sunken` type does not apply any shadows to the view
    case sunken
    /// `default` type does not apply any shadows to the view
    case `default`
    case raised
    case floating
    case overlay
}

/// Color used for Elevation shadows in the design system
enum ShadowColor {
    static let namedColor: Color = Color.gray
    
    static var color: Color {
        namedColor
    }
}

public extension View {
    /// Sets elevation of view by applying  shadows to the view
    func elevation(_ elevation: Elevation) -> some View {
        self.modifier(ElevationModifier(elevation: elevation))
    }
}

private struct ElevationModifier: ViewModifier {
    let elevation: Elevation
    
    func body(content: Content) -> some View {
        switch elevation {
        case .raised:
            content.raisedShadow()
        case .floating:
            content.floatingShadow()
        case .overlay:
            content.overlayShadow()
        case .sunken:
            content
        case .default:
            content
        }
    }
}

fileprivate extension View {
    func raisedShadow() -> some View {
        self
            .shadow(opacity: 0.08, blur: 4, y: 2)
            .shadow(opacity: 0.02, blur: 6, y: 0)
    }
    
    func floatingShadow() -> some View {
        self
            .shadow(opacity: 0.06, blur: 32, y: 10)
            .shadow(opacity: 0.02, blur: 14, y: 6)
    }
    
    func overlayShadow() -> some View {
        self
            .shadow(opacity: 0.14, blur: 88, y: 18)
            .shadow(opacity: 0.12, blur: 28, y: 8)
    }
    
    func shadow(opacity: CGFloat, blur: CGFloat, x: CGFloat = 0, y: CGFloat) -> some View {
        self
            .shadow(
                color: ShadowColor.color.opacity(opacity),
                radius: blur * 0.5,
                x: x,
                y: y
            )
    }
}

