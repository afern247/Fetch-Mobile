//
//  String+Extensions.swift
//  fetch
//
//  Created by Arturo on 10/16/24.
//

import Foundation

extension Optional where Wrapped == String {
    
    /// This computed property checks if the optional String is either nil or empty.
    /// It returns true if the optional String is nil or empty, and false otherwise.
    /// Example usage:
    /// let emptyString: String? = ""
    /// let isNilOrEmpty = emptyString.isEmptyOrNil // true
    var isEmptyOrNil: Bool {
        if let text = self, !text.isEmpty { return false }
        return true
    }
}
