//
//  HomeEntity.swift
//  Sports
//
//  Created by ios Dev on 09/05/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

// MARK: - MatchesRequest
struct MatchesRequest: Encodable {
    let pageNumber: Int
    let dated: String
    let matchStatus: FetchMatchStatus
    let groupBy: String
    
    enum CodingKeys: String, CodingKey {
        case pageNumber
        case dated
        case matchStatus
        case groupBy = "group_by"
    }
    
    init(pageNumber: Int, dated: String, matchStatus: FetchMatchStatus = .scheduled, groupBy: String = "tournament") {
        self.pageNumber = pageNumber
        self.dated = dated
        self.matchStatus = matchStatus
        self.groupBy = groupBy
    }
}

enum FetchMatchStatus: String, Encodable {
    case finished = "finished"
    case scheduled = "scheduled"
}

// MARK: - HomeEntity
struct HomeEntity: Codable {
    let matchList: [MatchList]?
}

// MARK: - MatchList
struct MatchList: Codable {
    let match: [Match]?
    let tournamentName: String?

    enum CodingKeys: String, CodingKey {
        case match
        case tournamentName = "tournament_name"
    }
}

// MARK: - Match
struct Match: Codable {
    let id: String?
    let score: [Score]?
    let timer: [Int]?
    let stats: [[Double]]?
    let details: Details?
}

// MARK: - Details
struct Details: Codable {
    let matchDetails: MatchDetails?
    let awayTeamDetail, homeTeamDetail: TeamDetail?
    let seasonDetails: SeasonDetails?
    let tournamentDetails: TournamentDetails?
    let venueDetails: VenueDetails?
    let liveMatch: Int?

    enum CodingKeys: String, CodingKey {
        case matchDetails = "match_details"
        case awayTeamDetail = "away_team_detail"
        case homeTeamDetail = "home_team_detail"
        case seasonDetails = "season_details"
        case tournamentDetails = "tournament_details"
        case venueDetails = "venue_details"
        case liveMatch = "live_match"
    }
}

// MARK: - TeamDetail
struct TeamDetail: Codable {
    let id: String?
    let competitionID: String?
    let countryID: String?
    let conferenceID: Int?
    let name, shortName: String?
    let logo: String?
    let national: Int?
    let coachID, venueID: String?
    let updatedAt: Int?
    let nameZht: String?
    let countryDetails: CountryDetails?

    enum CodingKeys: String, CodingKey {
        case id
        case competitionID = "competition_id"
        case countryID = "country_id"
        case conferenceID = "conference_id"
        case name
        case shortName = "short_name"
        case logo, national
        case coachID = "coach_id"
        case venueID = "venue_id"
        case updatedAt = "updated_at"
        case nameZht = "name_zht"
        case countryDetails
    }
}

// MARK: - CountryDetails
struct CountryDetails: Codable {
    let id: String?
    let categoryID: String?
    let name: String?
    let logo: String?
    let updatedAt: Int?
    let zhName: String?

    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case name, logo
        case updatedAt = "updated_at"
        case zhName = "zh_name"
    }
}

// MARK: - MatchDetails
struct MatchDetails: Codable {
    let id, competitionID, homeTeamID, awayTeamID: String?
    let statusID: MatchStatus?
    let kind, matchTime, neutral: Int?
    let homeScores, awayScores: [Int]?
    let periodCount: Int?
    let position: Position?
    let updatedAt: Int?
    let live: Bool?
    let stats: [[Double]]?
    let weather: Weather?
    let coverage: Coverage?
    let seasonID: String?

    enum CodingKeys: String, CodingKey {
        case id
        case competitionID = "competition_id"
        case homeTeamID = "home_team_id"
        case awayTeamID = "away_team_id"
        case kind
        case statusID = "status_id"
        case matchTime = "match_time"
        case neutral
        case homeScores = "home_scores"
        case awayScores = "away_scores"
        case periodCount = "period_count"
        case position
        case updatedAt = "updated_at"
        case live, stats, coverage, weather
        case seasonID = "season_id"
    }
}

// MARK: - Coverage
struct Coverage: Codable {
    let mlive: Int?
}

// MARK: - Position
struct Position: Codable {
    let home, away: String?
}

// MARK: - SeasonDetails
struct SeasonDetails: Codable {
    let id: String?
    let competitionID: String?
    let year: String?
    let hasPlayerStats, hasTeamStats, isCurrent, updatedAt: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case competitionID = "competition_id"
        case year
        case hasPlayerStats = "has_player_stats"
        case hasTeamStats = "has_team_stats"
        case isCurrent = "is_current"
        case updatedAt = "updated_at"
    }
}

// MARK: - TournamentDetails
struct TournamentDetails: Codable {
    let id: String?
    let categoryID: String?
    let countryID, name, shortName: String?
    let logo: String?
    let type: TournamentType?
    let nameZht: String?

    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case countryID = "country_id"
        case name
        case shortName = "short_name"
        case logo, type
        case nameZht = "name_zht"
    }
}

enum TournamentType: Int, Codable {
    case unknown = 0
    case league = 1
    case cup = 2
}

// MARK: - VenueDetails
struct VenueDetails: Codable {
    let id, name: String?
    let capacity: Int?
    let city: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, capacity, city
    }
}

// MARK: - Weather
struct Weather: Codable {
    let desc: String?
    let temp, wind, humidity, pressure: Int?
}

enum Score: Codable {
    case integer(Int)
    case integerArray([Int])
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode([Int].self) {
            self = .integerArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Score.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Score"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .integerArray(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
