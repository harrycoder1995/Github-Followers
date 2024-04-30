//
//  Endpoints.swift
//  GithubFollowers
//
//  Created by Harendra Rana on 04/04/24.
//

import Foundation

final class ResponseDecoder {
    
    static func decodeResponse<T: Decodable>(_ data: Data?, _ urlResponse: URLResponse?) throws -> T {
        guard let httpResponse = urlResponse as? HTTPURLResponse else {
                   throw GFError.invalidResponse
               }
               
               
        if httpResponse.statusCode >= 200 || httpResponse.statusCode < 300 {
            return try decodeData(data)
        }else {
            return GFError.invalidResponse as! T
        }
    }
    
    static func decodeData<T: Decodable>(_ data: Data?) throws -> T {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data ?? Data())
        } catch {
            throw GFError.unableToParseData
        }
    }
}
