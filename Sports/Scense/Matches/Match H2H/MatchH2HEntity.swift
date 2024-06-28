//
//  MatchH2HEntity.swift
//  Sports
//
//  Created by ios Dev on 24/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

// MARK: - H2H Request Model
struct HeadToHeadRequest: Encodable {
    let matchID: String
    let homeTeamID: String
    let awayTeamID: String
    
    enum CodingKeys: String, CodingKey {
        case matchID = "match_id"
        case homeTeamID = "home_team_id"
        case awayTeamID = "away_team_id"
    }
}

enum H2HSection: Int, CaseIterable {
    case selection
    case matches
}

enum TeamSelection: Int, CaseIterable {
    case vs = 0
    case home = 1
    case away = 2
    
    var description: String {
        switch self {
        case .vs: return "VS"
        case .home: return "Home"
        case .away: return "Away"
        }
    }
}

// MARK: - MatchH2HEntity
struct MatchH2HEntity: Codable {
    let code: Int?
    let results: Results?
}

// MARK: - Results
struct Results: Codable {
    let info: [ResultsInfo]?
    let history: History?
}

// MARK: - History
struct History: Codable {
    let vs, home, away: [H2HMatch]?
}

// MARK: - VElement
struct H2HMatch: Codable {
    let the0: String?
    let the1: Int?
    let the2: String?
    let the3, the4, the5: Int?
    let the6, the7: [The6_Element]?
    let the8, the9: [String]?
    let homeTeamDetail, awayTeamDetail: TeamDetail?

    enum CodingKeys: String, CodingKey {
        case the0 = "0"
        case the1 = "1"
        case the2 = "2"
        case the3 = "3"
        case the4 = "4"
        case the5 = "5"
        case the6 = "6"
        case the7 = "7"
        case the8 = "8"
        case the9 = "9"
        case homeTeamDetail = "home_team_detail"
        case awayTeamDetail = "away_team_detail"
    }
}

enum The6_Element: Codable {
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
        throw DecodingError.typeMismatch(The6_Element.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for The6_Element"))
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

enum ResultsInfo: Codable {
    case integer(Int)
    case string(String)
    case unionArray([The6_Element])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode([The6_Element].self) {
            self = .unionArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(ResultsInfo.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ResultsInfo"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        case .unionArray(let x):
            try container.encode(x)
        }
    }
}
