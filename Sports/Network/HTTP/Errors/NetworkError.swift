//
//  NetworkError.swift
//  BetsApp
//
//  Created by Omar Abdulrahman on 27/03/2024.
//

import Foundation

enum RequestError: Error, Identifiable {
    case decode
    case invalidURL
    case noResponse
    case notFound
    case unauthorized
    case unexpectedStatusCode
    case unknown
    case badRequest
    case apiError(String)

    var id: String {
        return UUID().uuidString
    }
}

enum NetworkError: Error {
    case noInternetConnection
}
