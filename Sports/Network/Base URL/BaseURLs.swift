//
//  BaseURLs.swift
//  BetsApp
//
//  Created by Omar Abdulrahman on 28/03/2024.
//

import Foundation

enum BuildSettingsKey: String {
    case TOURNAMENTS
    case NEWS
    case HIGHLIGHTS
    case AUTH
    
    var value: String {
        get {
            return Bundle.main.infoDictionary![self.rawValue] as! String
        }
    }
}

