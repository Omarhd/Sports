//
//  Int+Extension.swift
//  Sports
//
//  Created by ios Dev on 20/06/2024.
//

import Foundation

extension Int {
    
    func toDateString(format: String = "MM-dd HH:mm") -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
}
