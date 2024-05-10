//
//  HTTPHeader.swift
//  BetsApp
//
//  Created by Omar Abdulrahman on 27/03/2024.
//

import Foundation

struct APIHeaders {
    static let contentType = "Content-Type"
    static let accept = "Accept"
    static let language = "lang"
    
    static func defaultHeaders() -> [String: String] {
        return [
            contentType: "application/json",
            accept: "application/json",
            language: "en"
        ]
    }
}
