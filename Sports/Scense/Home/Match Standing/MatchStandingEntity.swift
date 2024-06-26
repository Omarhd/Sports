//
//  MatchStandingEntity.swift
//  Sports
//
//  Created by ios Dev on 24/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

// MARK: - MatchStandingEntity Request
struct StandingSeasonRequest: Encodable {
    let seasonID: String
}

// MARK: - MatchStandingEntity
struct StandingSeasonEntity: Codable {
    let standingsData: [StandingsData]?
}

// MARK: - StandingsData
struct StandingsData: Codable {
    let teamID: String?
    let position, won: Int?
    let away, home: String?
    let lost: Int?
    let last10: String?
    let streaks: Int?
    let diffAvg: Double?
    let division: String?
    let wonRate: Double?
    let gameBack, conference: String?
    let pointsAvg, pointsAgainstAvg: Double?
    let updatedAt: Int?
    let teamInfo: TeamInfo?

    enum CodingKeys: String, CodingKey {
        case teamID = "team_id"
        case position, won, away, home, lost
        case last10 = "last_10"
        case streaks
        case diffAvg = "diff_avg"
        case division
        case wonRate = "won_rate"
        case gameBack = "game_back"
        case conference
        case pointsAvg = "points_avg"
        case pointsAgainstAvg = "points_against_avg"
        case updatedAt = "updated_at"
        case teamInfo
    }
}

// MARK: - TeamInfo
struct TeamInfo: Codable {
    let id: String?
    let competitionID: String?
    let countryID: String?
    let conferenceID: Int?
    let name, shortName: String?
    let logo: String?
    let national: Int?
    let coachID, venueID: String?
    let updatedAt: Int?
    let cnName: String?

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
        case cnName = "cn_name"
    }
}


enum SeasonSection: Int, CaseIterable {
    case selection
    case teams
}

enum SeasonSelection: Int, CaseIterable {
    case short = 0
    case full = 1
    
    var description: String {
        switch self {
        case .short: return "Short"
        case .full: return "Full"
        }
    }
}
