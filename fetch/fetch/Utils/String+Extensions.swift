//
//  String+Extensions.swift
//  fetch
//
//  Created by Arturo on 10/16/24.
//

import CryptoKit
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
    
    /// Generates a SHA-256 hash of the string.
    /// This is used to create a unique identifier for each URL, ensuring that images with the same filename
    /// but different URLs (e.g., `https://example.com/image.png` vs `https://another.com/image.png`)
    /// are stored separately on disk.
    func sha256() -> String {
        let data = Data(self.utf8)
        let hash = SHA256.hash(data: data)
        return hash.compactMap { String(format: "%02x", $0) }.joined()
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
