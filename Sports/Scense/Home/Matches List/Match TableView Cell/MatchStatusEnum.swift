//
//  MatchStatusEnum.swift
//  Sports
//
//  Created by ios Dev on 20/06/2024.
//

import Foundation

enum MatchStatus: Int, Codable {
    case abnormal = 0              // Abnormal (suggest hiding)
    case notStarted = 1            // Not started
    case sectionOne = 2            // Section One
    case sectionOneOver = 3        // Section One Over
    case sectionTwo = 4            // Section Two
    case sectionTwoOver = 5        // Section Two Over
    case sectionThree = 6          // Section Three
    case sectionThreeOver = 7      // Section Three Over
    case sectionFour = 8           // Section Four
    case overtime = 9              // Overtime
    case end = 10                  // End
    case interrupt = 11            // Interrupt
    case cancel = 12               // Cancel
    case extensions = 13           // Extension
    case cutInHalf = 14            // Cut in half
    case toBeDetermined = 15       // To be determined
    
    var description: String {
        switch self {
        case .abnormal:
            return "Abnormal (suggest hiding)"
        case .notStarted:
            return "Not started"
        case .sectionOne:
            return "Section One"
        case .sectionOneOver:
            return "Section One Over"
        case .sectionTwo:
            return "Section Two"
        case .sectionTwoOver:
            return "Section Two Over"
        case .sectionThree:
            return "Section Three"
        case .sectionThreeOver:
            return "Section Three Over"
        case .sectionFour:
            return "Section Four"
        case .overtime:
            return "Overtime"
        case .end:
            return "End"
        case .interrupt:
            return "Interrupt"
        case .cancel:
            return "Cancel"
        case .extensions:
            return "Extension"
        case .cutInHalf:
            return "Cut in half"
        case .toBeDetermined:
            return "To be determined"
        }
    }
}
