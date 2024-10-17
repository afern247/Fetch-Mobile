//
//  DecodableDefault.swift
//  fetch
//
//  Created by Arturo on 10/16/24.
//

import Foundation

/// Property wrapper for setting a default value for missing / null fields.
@propertyWrapper
public struct DecodableDefault<Default: DefaultDecodableValue>: Decodable {
    public var wrappedValue: Default.Value
    
    public init(wrappedValue: Default.Value) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.wrappedValue = (try? container.decode(Default.Value.self)) ?? Default.defaultValue
    }
}

extension KeyedDecodingContainer {
    
    public func decode<T>(_: DecodableDefault<T>.Type,
                          forKey key: KeyedDecodingContainer<K>.Key) throws -> DecodableDefault<T> {
        if let value = try decodeIfPresent(DecodableDefault<T>.self, forKey: key) {
            return value
        }
        return DecodableDefault(wrappedValue: T.defaultValue)
    }
}

extension DecodableDefault: Encodable where Default.Value: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        try wrappedValue.encode(to: encoder)
    }
    
}

extension DecodableDefault: Equatable where Default.Value: Equatable { }
extension DecodableDefault: Hashable where Default.Value: Hashable { }

// MARK: - Default value types

/// A Decodable type that can provide a default value for a missing/null field
public protocol DefaultDecodableValue {
    associatedtype Value: Decodable
    
    static var defaultValue: Value { get }
}

/// Defaults numeric types to `0` when decoding a missing/null field
public enum DefaultZero<T: Numeric & Decodable>: DefaultDecodableValue {
    public typealias Value = T
    
    public static var defaultValue: Value { 0 }
}

/// Defaults a Bool to `false` when decoding a missing/null field
public enum DefaultFalse: DefaultDecodableValue {
    public static var defaultValue: Bool { false }
}

/// Defaults a Bool to `true` when decoding a missing/null field
public enum DefaultTrue: DefaultDecodableValue {
    public static var defaultValue: Bool { true }
}

/// Defaults a String to `""` when decoding a missing/null field
public enum DefaultEmptyString: DefaultDecodableValue {
    public static var defaultValue: String { "" }
}

/// Defaults an Array to `[]` when decoding a missing/null field
public enum DefaultEmptyArray<T: Decodable>: DefaultDecodableValue {
    public static var defaultValue: [T] { [] }
}

/// Defaults a Date to `Date()` when decoding a missing/null field
public enum DefaultCurrentDate: DefaultDecodableValue {
    public static var defaultValue: Date { Date() }
}

/// Defaults a Dictionary to `[:]` when decoding a missing/null field
public enum DefaultEmptyDictionary<K: Hashable & Decodable, V: Decodable>: DefaultDecodableValue {
    public static var defaultValue: [K: V] { [:] }
}
