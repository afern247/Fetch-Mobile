//
//  Color.swift
//  fetch
//
//  Created by Arturo on 10/16/24.
//

import SwiftUI

extension Color {
    
    public static let allFColors: [Color] = FColor.allCases.map { $0.color }
    
    public static let f100 = FColor.f100.color
    public static let f110 = FColor.f100.color
    public static let f200 = FColor.f100.color
    public static let f220 = FColor.f220.color
    public static let f500 = FColor.f100.color
    public static let f600 = FColor.f100.color
    public static let f810 = FColor.f810.color
    public static let f880 = FColor.f100.color
    public static let f900 = FColor.f100.color
}

extension Color {
    
    public static var brandPrimary = Color.f810
    public static var brandSecondary = Color.f880
    public static var fillPrimary = Color.f900
    public static var fillSecondary = Color.f500
    
    public static var bgPrimaryArea = Color.f200
    public static var bgProminentArea = Color.f110
    public static var bgCommonElement = Color.f600
    
    public static var fillButtonBorder = Color.f220
}

extension Color {
    
    init(hex: String, opacity: Double = 1.0) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b) = (
                (int >> 8) * 17,
                (int >> 4 & 0xF) * 17,
                (int & 0xF) * 17
            )
        case 6: // RGB (24-bit)
            (r, g, b) = (
                int >> 16,
                int >> 8 & 0xFF,
                int & 0xFF
            )
        default:
            (r, g, b) = (1, 1, 1) // Default to white for invalid input
        }
        
        self.init(
            red: Double(r) / 255.0,
            green: Double(g) / 255.0,
            blue: Double(b) / 255.0,
            opacity: opacity
        )
    }
    
    var uiColor: UIColor { return UIColor(self) }
    
    var cgColor: CGColor { UIColor(self).resolvedColor(with: UITraitCollection.current).cgColor }
}
