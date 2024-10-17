//
//  String+Extensions.swift
//  fetch
//
//  Created by Arturo on 10/16/24.
//

import Foundation

extension String {
    /// Checks if the string is empty or contains only whitespace characters.
    ///
    /// This function trims any whitespace characters from the string and checks if the
    /// result is an empty string.
    ///
    /// - Returns: `true` if the string is empty or contains only whitespace characters, `false` otherwise.
    ///
    /// Example usage:
    /// ```
    /// let inputString = "  "
    /// if inputString.isEmptyOrWhiteSpace() {
    ///     log.debug("The string is empty or contains only whitespace.")
    /// }
    /// ```
    func isEmptyOrWhiteSpace() -> Bool {
        if !self.trimmingCharacters(in: .whitespaces).isEmpty {
            // string contains non-whitespace characters
            return false
        } else {
            // String is empty
            return true
        }
    }
}

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
