//
//  MatchOddsEntity.swift
//  Sports
//
//  Created by ios Dev on 24/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

// MARK: - MatchOddsEntity
struct MatchOddsEntity: Codable {
    let data: [DatumClass]?
}

// MARK: - DatumClass
struct DatumClass: Codable {
    let code: Code?
    let data: [[DatumUnion]]?
}

enum Code: String, Codable {
    case asia = "asia"
    case bs = "bs"
    case eu = "eu"
}

enum DatumUnion: Codable {
    case double(Double)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(DatumUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for DatumUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}


struct OddsRequest: Encodable {
    let matchID: String
    
    enum CodingKeys: String, CodingKey {
        case matchID = "match_id"
    }
}

enum OddsSection: Int, CaseIterable {
    case selection
    case odds
}

enum OddsSelection: Int, CaseIterable {
    case spread = 0
    case toWin = 1
    case totalPoints = 2
    
    var description: String {
        switch self {
        case .spread: return "Spread"
        case .toWin: return "To Win"
        case .totalPoints: return "Total Points"
        }
    }
}
