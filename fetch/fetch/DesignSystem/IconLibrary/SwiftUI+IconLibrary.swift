//
//  SwiftUI+IconLibrary.swift
//  fetch
//
//  Created by Arturo on 10/16/24.
//

import SwiftUI

extension Image {
    
    /// Creates an `Image` that contains an image from the icon library for `Illustration`s.
    ///
    /// - Parameter illustration: The `Illustration` image.
    public init(illustration: Illustration) {
        self = Image(decorative: "illustration.\(illustration.rawValue)")
    }
}
