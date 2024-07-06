//
//  ErrorModel.swift
//  Sports
//
//  Created by ios Dev on 06/07/2024.
//

import Foundation

struct ErrorResponse: Decodable, Error {
    let message: String
    let errors: [String: [String]]
    
    static func decode(from data: Data) throws -> ErrorResponse {
        let decoder = JSONDecoder()
        return try decoder.decode(ErrorResponse.self, from: data)
    }
    
    func compactErrorString() -> String {
        var compactString = "\(message): "
        for (key, errorsArray) in errors {
            compactString += "\(key) - \(errorsArray.joined(separator: ", ")); "
        }
        return String(compactString.dropLast(2))
    }
}
