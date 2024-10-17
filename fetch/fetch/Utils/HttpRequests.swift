//
//  HttpRequests.swift
//  fetch
//
//  Created by Arturo on 10/16/24.
//

import Foundation

enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

struct NetworkHandler {
    
    /// Makes an asynchronous network request and returns the raw data.
    /// - Parameters:
    ///   - urlString: The URL string to make the request to.
    ///   - method: The HTTP method to use (GET, POST, etc.).
    /// - Returns: The raw `Data` from the response, or `nil` if an error occurs.
    ///
    /// Sample usage:
    /// ```swift
    /// let data = await NetworkHandler.request(urlString: "https://api.example.com", method: .get)
    /// ```
    static func request(urlString: String, method: HTTPMethod) async -> Data? {
        guard let url = URL(string: urlString) else {
            log.error("Invalid URL: \(urlString)")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse {
                if (400..<500).contains(httpResponse.statusCode) {
                    log.error("Response Status Code: \(httpResponse.statusCode)")
                } else if (500..<600).contains(httpResponse.statusCode) {
                    log.error("Response Status Code: \(httpResponse.statusCode)")
                }
            }
            
            return data
        } catch {
            log.error("Error fetching data from \(urlString): \(error)")
            return nil
        }
    }
    
    /// Makes an asynchronous network request, decodes the response into a specified type, and returns the decoded object.
    /// - Parameters:
    ///   - urlString: The URL string to make the request to.
    ///   - method: The HTTP method to use (GET, POST, etc.).
    /// - Returns: The decoded object of type `T`, or `nil` if an error occurs.
    ///
    /// Sample usage:
    /// ```swift
    /// struct MyData: Decodable { let id: Int }
    /// let decodedData: MyData? = await NetworkHandler.requestAndDecode(urlString: "https://api.example.com", method: .get)
    /// ```
    static func requestAndDecode<T: Decodable>(urlString: String, method: HTTPMethod) async -> T? {
        guard let data = await request(urlString: urlString, method: method) else { return nil }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            log.error("Failed to decode data: \(error.localizedDescription)")
            return nil
        }
    }
}
