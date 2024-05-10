//
//  HomeEntity.swift
//  Sports
//
//  Created by ios Dev on 09/05/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

// MARK: - TournamentRequest
struct TournamentRequest: Encodable {
    let pageNumber: Int
}

// MARK: - HomeEntity
struct HomeEntity: Codable {
    let currentPage, totalPages: Int?
    let results: [Result]?
}

// MARK: - Result
struct Result: Codable {
    let id, categoryID: String?
    let countryID: String?
    let name, shortName: String?
    let logo: String?
    let type: Int?
    let curSeasonID, curStageID: String?
    let curRound, roundCount: Int?
    let titleHolder: [TitleHolder]?
    let mostTitles: [MostTitle]?
    let primaryColor, secondaryColor: String?
    let updatedAt: Int?
    let nameZht: String?

    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case countryID = "country_id"
        case name
        case shortName = "short_name"
        case logo, type
        case curSeasonID = "cur_season_id"
        case curStageID = "cur_stage_id"
        case curRound = "cur_round"
        case roundCount = "round_count"
        case titleHolder = "title_holder"
        case mostTitles = "most_titles"
        case primaryColor = "primary_color"
        case secondaryColor = "secondary_color"
        case updatedAt = "updated_at"
        case nameZht = "name_zht"
    }
}

enum MostTitle: Codable {
    case integer(Int)
    case stringArray([String])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode([String].self) {
            self = .stringArray(x)
            return
        }
        throw DecodingError.typeMismatch(MostTitle.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for MostTitle"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .stringArray(let x):
            try container.encode(x)
        }
    }
}

enum TitleHolder: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(TitleHolder.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for TitleHolder"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
