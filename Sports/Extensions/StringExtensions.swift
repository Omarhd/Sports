//
//  StringExtensions.swift
//  ChatApp
//
//  Created by ios Dev on 08/05/2024.
//

import Foundation

extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
}
