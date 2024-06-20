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
    let matchStatus: String
    let groupBy: String
    
    enum CodingKeys: String, CodingKey {
        case pageNumber
        case dated
        case matchStatus
        case groupBy = "group_by"
    }
    
    init(pageNumber: Int, dated: String, matchStatus: String, groupBy: String = "tournament") {
        self.pageNumber = pageNumber
        self.dated = dated
        self.matchStatus = matchStatus
        self.groupBy = groupBy
    }
}

// MARK: - HomeEntity
struct HomeEntity: Codable {
    let matchList: [MatchList]?
}

// MARK: - MatchList
struct MatchList: Codable {
    let tournamentID, tournamentName: String?
    let match: [Match]?

    enum CodingKeys: String, CodingKey {
        case tournamentID = "tournament_id"
        case tournamentName = "tournament_name"
        case match
    }
}

// MARK: - Details
struct Details: Codable {
    let matchDetails: Match?
    let awayTeamDetail, homeTeamDetail: TeamDetail?
    let seasonDetails: SeasonDetails?
    let tournamentDetails: TournamentDetails?
    let venueDetails: VenueDetails?
    let liveMatch: Int?
    let refereeDetail: RefereeDetail?

    enum CodingKeys: String, CodingKey {
        case matchDetails = "match_details"
        case awayTeamDetail = "away_team_detail"
        case homeTeamDetail = "home_team_detail"
        case seasonDetails = "season_details"
        case tournamentDetails = "tournament_details"
        case venueDetails = "venue_details"
        case liveMatch = "live_match"
        case refereeDetail = "referee_detail"
    }
}

// MARK: - Match
class Match: Codable {
    let id: String?
    let seasonID: String?
    let competitionID, homeTeamID, awayTeamID: String?
    let statusID, matchTime: Int?
    let venueID, refereeID: String?
    let neutral: Int?
    let note: String?
    let homeScores, awayScores: [Int]?
    let homePosition, awayPosition: String?
    let coverage: Coverage?
    let round: Round?
    let updatedAt: Int?
    let live: Bool?
    let matchTiming: String?
    let details: Details?
    let updatedAtFormated: String?
    let environment: MatchEnvironment?

    enum CodingKeys: String, CodingKey {
        case id
        case seasonID = "season_id"
        case competitionID = "competition_id"
        case homeTeamID = "home_team_id"
        case awayTeamID = "away_team_id"
        case statusID = "status_id"
        case matchTime = "match_time"
        case venueID = "venue_id"
        case refereeID = "referee_id"
        case neutral, note
        case homeScores = "home_scores"
        case awayScores = "away_scores"
        case homePosition = "home_position"
        case awayPosition = "away_position"
        case coverage, round
        case updatedAt = "updated_at"
        case live
        case matchTiming = "match_timing"
        case details
        case updatedAtFormated = "updated_at_formated"
        case environment
    }
}

// MARK: - TeamDetail
struct TeamDetail: Codable {
    let id, competitionID: String?
    let countryID: String?
    let name, shortName: String?
    let logo: String?
    let national: Int?
    let countryLogo: String?
    let foundationTime: Int?
    let website: String?
    let coachID, venueID: String?
    let marketValue: Int?
    let marketValueCurrency: String?
    let totalPlayers, foreignPlayers, nationalPlayers, updatedAt: Int?
    let nameZhn, nameZht: String?

    enum CodingKeys: String, CodingKey {
        case id
        case competitionID = "competition_id"
        case countryID = "country_id"
        case name
        case shortName = "short_name"
        case logo, national
        case countryLogo = "country_logo"
        case foundationTime = "foundation_time"
        case website
        case coachID = "coach_id"
        case venueID = "venue_id"
        case marketValue = "market_value"
        case marketValueCurrency = "market_value_currency"
        case totalPlayers = "total_players"
        case foreignPlayers = "foreign_players"
        case nationalPlayers = "national_players"
        case updatedAt = "updated_at"
        case nameZhn = "name_zhn"
        case nameZht = "name_zht"
    }
}

// MARK: - RefereeDetail
struct RefereeDetail: Codable {
}

// MARK: - SeasonDetails
struct SeasonDetails: Codable {
    let id, competitionID, year: String?
    let hasPlayerStats, hasTeamStats, hasTable, isCurrent: Int?
    let startTime, endTime, updatedAt: Int?
    let updatedAtFormated: String?

    enum CodingKeys: String, CodingKey {
        case id
        case competitionID = "competition_id"
        case year
        case hasPlayerStats = "has_player_stats"
        case hasTeamStats = "has_team_stats"
        case hasTable = "has_table"
        case isCurrent = "is_current"
        case startTime = "start_time"
        case endTime = "end_time"
        case updatedAt = "updated_at"
        case updatedAtFormated = "updated_at_formated"
    }
}

// MARK: - TournamentDetails
struct TournamentDetails: Codable {
    let id: String?
    let categoryID: String?
    let countryID: String?
    let name, shortName: String?
    let logo: String?
    let type: Int?
    let curSeasonID: String?
    let curStageID: String?
    let curRound, roundCount: Int?
    let newcomers: [[String]]?
    let divisions: [[String]]?
    let primaryColor: String?
    let secondaryColor: String?
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
        case newcomers, divisions
        case primaryColor = "primary_color"
        case secondaryColor = "secondary_color"
        case updatedAt = "updated_at"
        case nameZht = "name_zht"
    }
}

// MARK: - VenueDetails
struct VenueDetails: Codable {
    let id, name: String?
    let capacity: Int?
    let countryID: String?
    let city: String?
    let country: String?
    let updatedAt: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, capacity
        case countryID = "country_id"
        case city, country
        case updatedAt = "updated_at"
    }
}

// MARK: - Coverage
struct Coverage: Codable {
    let mlive, lineup: Int?
}

// MARK: - Environment
struct MatchEnvironment: Codable {
    let weather: Int?
    let pressure, temperature, wind, humidity: String?
}

// MARK: - Round
struct Round: Codable {
    let stageID: String?
    let roundNum, groupNum: Int?

    enum CodingKeys: String, CodingKey {
        case stageID = "stage_id"
        case roundNum = "round_num"
        case groupNum = "group_num"
    }
}
