//
//  Double+Extension.swift
//  Sports
//
//  Created by ios Dev on 26/06/2024.
//

import Foundation

extension Double {
    
    func toDateString(format: String = "h:mm a EEEE, MMMM d, yyyy") -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    var isNegative: Bool {
        return self < 0
    }
    /// A Boolean value indicating whether this instance is negative.
    ///
}
