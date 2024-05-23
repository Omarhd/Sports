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
            return NSLocalizedString("Invalid URL".localized, comment: "Request Error".localized)
        case .badRequest:
            return NSLocalizedString("No matching location found.".localized, comment: "Request Error".localized)
        case .noResponse:
            return NSLocalizedString("No Response".localized, comment: "Request Error".localized)
        case .unauthorized:
            return NSLocalizedString("Unauthorized".localized, comment: "Request Error".localized)
        case .unexpectedStatusCode:
            return NSLocalizedString("Unexpected Status Code.".localized, comment: "Request Error".localized)
        case .decode:
            return NSLocalizedString("Decoding Error".localized, comment: "Request Error".localized)
        case .unknown:
            return NSLocalizedString("Unknown Error".localized, comment: "Request Error".localized)
        case .apiError(let message):
            return NSLocalizedString("API Error".localized, comment: message)
        case .notFound:
            return NSLocalizedString("API Error".localized, comment: "Not Found".localized)

        }
    }
    
}
