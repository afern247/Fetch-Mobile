//
//  Typography+SwiftUI.swift
//  fetch
//
//  Created by Arturo on 10/16/24.
//

import SwiftUI

struct FFont: ViewModifier {
    
    @Environment(\.sizeCategory) var sizeCategory
    
    var textStyle: TypographyType
    var weight: Font.Weight?
    var design: Font.Design?
    var textAlignment: TextAlignment?
    var color: Color?
    var opacity: Double?
    var multiline: Bool?
    
    func body(content: Content) -> some View {
        return content
            .font(.system(size: textStyle.attributes.size, weight: weight ?? textStyle.attributes.weight, design: design ?? .default))
            .kerning(textStyle.kerning)
            .multilineTextAlignment(textAlignment ?? .leading)
            .lineLimit(multiline ?? false ? nil : 1)
            .foregroundColor(color)
            .opacity(opacity ?? 1)
    }
}

extension Text {
    func typography(_ textStyle: TypographyType? = nil,
             weight: Font.Weight? = nil,
             design: Font.Design? = nil,
             textAlignment: TextAlignment? = nil,
             color: Color? = nil,
             opacity: Double? = nil,
             multiline: Bool? = nil) -> some View {
        self.modifier(FFont(textStyle: textStyle ?? TypographyType.bodyLarge, weight: weight, design: design, textAlignment: textAlignment, color: color, opacity: opacity, multiline: multiline))
    }
}

/// `ApplyTextModifierIfText` is a view modifier that applies the `.set(...)` modifier
/// with specific textStyle, weight, and color properties if the input view is of `Text` type.
/// If the input view is not a `Text` view, it doesn't apply any modification.
struct ApplyTextModifierIfText: ViewModifier {
    var textStyle: TypographyType?
    var weight: Font.Weight?
    var color: Color?
    
    func body(content: Content) -> some View {
        applyTextStyleIfNeeded(to: content, textStyle: textStyle, weight: weight, color: color)
    }
}

/// The `applyTextStyleIfNeeded` function checks whether the input view is of `Text` type
/// and applies the `.set(...)` modifier with specific textStyle, weight, and color properties
/// if it is. If the input view is not a `Text` view, it returns the unmodified view.
func applyTextStyleIfNeeded<V: View>(to view: V, textStyle: TypographyType?, weight: Font.Weight?, color: Color?) -> some View {
    if let textView = view as? Text {
        return AnyView(textView.typography(textStyle, weight: weight, color: color))
    } else {
        return AnyView(view.foregroundColor(color))
    }
}

