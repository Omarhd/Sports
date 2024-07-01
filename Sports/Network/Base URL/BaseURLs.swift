//
//  BaseURLs.swift
//  BetsApp
//
//  Created by Omar Abdulrahman on 28/03/2024.
//

import Foundation

enum BuildSettingsKey: String {
    case BASE_URL
    case AUTH_BASE_URL
    case TOURNAMENTS
    case NEWS
    case HIGHLIGHTS
    
    var value: String {
        get {
            return Bundle.main.infoDictionary![self.rawValue] as! String
        }
    }
}

