//
//  NetworkErrorExtension.swift
//  BetsApp
//
//  Created by Omar Abdulrahman on 27/03/2024.
//

import Foundation

extension RequestError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "Request Error")
        case .badRequest:
            return NSLocalizedString("No matching location found.", comment: "Request Error")
        case .noResponse:
            return NSLocalizedString("No Response", comment: "Request Error")
        case .unauthorized:
            return NSLocalizedString("Unauthorized", comment: "Request Error")
        case .unexpectedStatusCode:
            return NSLocalizedString("Unexpected Status Code.", comment: "Request Error")
        case .decode(let data):
            do {
                let errorResponse = try ErrorResponse.decode(from: data)
                return errorResponse.compactErrorString()
            } catch {
                return NSLocalizedString("Decoding Error", comment: "Request Error")
            }
        case .unknown:
            return NSLocalizedString("Unknown Error", comment: "Request Error")
        case .apiError(let message):
            return NSLocalizedString("API Error: \(message)", comment: "Request Error")
        case .notFound:
            return NSLocalizedString("Not Found", comment: "Request Error")
        }
    }
}
