//
//  HomeDateEntity.swift
//  Sports
//
//  Created by ios Dev on 19/06/2024.
//

import Foundation

enum MatchType {
    case live
    case dated
}

enum SpecialDate {
    case today
    case yesterday
    case tomorrow
    case other(Date)
    
    static func from(date: Date, calendar: Calendar) -> SpecialDate {
        if calendar.isDateInToday(date) {
            return .today
        } else if calendar.isDateInYesterday(date) {
            return .yesterday
        } else if calendar.isDateInTomorrow(date) {
            return .tomorrow
        } else {
            return .other(date)
        }
    }
    
    func formattedString(dateFormatter: DateFormatter) -> String {
        switch self {
        case .today:
            return "Today".localized
        case .yesterday:
            return "Yesterday".localized
        case .tomorrow:
            return "Tomorrow".localized
        case .other(let date):
            return dateFormatter.string(from: date)
        }
    }
}

struct DateModel {
    let date: Date
    let formattedString: String
}
