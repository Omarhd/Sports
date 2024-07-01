//
//  HomeHighlightsEntity.swift
//  Sports
//
//  Created by ios Dev on 27/06/2024.
//

import Foundation

// MARK: - NewsEntity
struct HomeHighlightsEntity: Decodable {
    let response: NewsResponse?
}

// MARK: - Response
struct NewsResponse: Codable {
    let news: [HighlightsNews]?
    let code: Int?
    let messages: [String]?
}

// MARK: - News
struct HighlightsNews: Codable {
    let thumbnail: String?
    let headline, detail: String?
}
