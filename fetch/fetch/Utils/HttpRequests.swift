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
