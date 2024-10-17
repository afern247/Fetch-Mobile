//
//  fColor.swift
//  fetch
//
//  Created by Arturo on 10/16/24.
//

import SwiftUI

public enum FColor: Hashable, CaseIterable {
    
    case f100
    case f110
    case f200
    case f220
    case f500
    case f600
    case f810
    case f880
    case f900
    
    var color: Color {
        switch self {
            
        case .f100: return Color(hex: "FFFFFF")
        case .f110: return Color(hex: "F4F5F6")
        case .f200: return Color(hex: "F2F2F6")
        case .f220: return Color(hex: "D4DCF0")
        case .f500: return Color(hex: "716F84")
        case .f600: return Color(hex: "F8F8FF")
        case .f810: return Color(hex: "F8AC18")
        case .f880: return Color(hex: "FFFF20")
        case .f900: return Color(hex: "000000")
        }
    }
}
