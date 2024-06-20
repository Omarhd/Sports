//
//  Date+Extension.swift
//  Sports
//
//  Created by ios Dev on 19/06/2024.
//

import Foundation

extension Date {
    
    func toFormattedString() -> String {
        let outputDateFormat = "yyyy-MM-dd"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = outputDateFormat
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        return dateFormatter.string(from: self)
    }
}
