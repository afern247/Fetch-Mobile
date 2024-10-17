//
//  Log.swift
//  fetch
//
//  Created by Arturo on 10/16/24.
//

import Foundation

enum LogType {
    case error, warn, debug
}

var log = Logger.self

class Logger {
    
    static func error(_ message: String, _ args: Any...) {
        log(message, args, type: .error)
    }
    
    static func warn(_ message: String, _ args: Any...) {
        log(message, args, type: .warn)
    }
    
    static func debug(_ message: String, _ args: Any...) {
        log(message, args, type: .debug)
    }
    
    static func debug(_ error: Error?, _ message: String = "Unknown error") {
        let errorMessage = error.map { extractMessage(from: $0) } ?? message
        log(errorMessage, [], type: .debug)
    }
    
    private static func log(_ message: String, _ args: [Any], type: LogType) {
        let composedMessage = args.compactMap { arg -> String? in
            if let error = arg as? CustomStringConvertible {
                return error.description
            } else {
                return String(describing: arg)
            }
        }.joined(separator: " ")

        #if DEBUG
        print(composedMessage)
        #endif
    }
    
    private static func extractMessage(from error: Error) -> String {
        if let error = error as? LocalizedError, let errorDescription = error.errorDescription {
            return errorDescription
        } else {
            return error.localizedDescription
        }
    }
}
