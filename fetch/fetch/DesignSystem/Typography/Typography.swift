//
//  Typography.swift
//  fetch
//
//  Created by Arturo on 10/16/24.
//

import SwiftUI

enum TypographyType {
    
    /// Prominent numbers in data visualizations, such as key figures or totals that need to stand out
    case displayNumber
    
    /// Display text on main tab screens, such as headings or titles for featured content
    case title
    
    /// Section titles and large featured card titles
    case headerLarge
    
    /// Large labels, including navigation bar titles and most card titles
    case headerSmall
    
    /// Main body text and input fields
    case bodyLarge
    
    /// Secondary body text
    case bodySmall
    
    /// Large button text and action row text
    case labelLarge
    
    /// Small button text, small labels for secondary navigation, and small card titles
    case labelMedium
    
    /// Input labels
    case labelSmall
    
    /// Tags and badges
    case overline
    
    /// Captions, metadata, and tooltips
    case caption

    var attributes: (size: CGFloat, weight: Font.Weight) {
        
        switch self {
            
        case .displayNumber: return (48, .bold)
        case .title: return (28, .semibold)
        case .headerLarge: return (20, .semibold)
        case .headerSmall: return (18, .medium)
        case .bodyLarge: return (16, .regular)
        case .bodySmall: return (14, .regular)
        case .labelLarge: return (16, .medium)
        case .labelMedium: return (14, .regular)
        case .labelSmall: return (12, .medium)
        case .overline: return (12, .medium)
        case .caption: return (12, .regular)
        }
    }
    
    var kerning: CGFloat { return 0.0 }
}

