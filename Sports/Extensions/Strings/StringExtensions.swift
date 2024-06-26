//
//  StringExtensions.swift
//  ChatApp
//
//  Created by ios Dev on 08/05/2024.
//

import UIKit

extension String {
    
    var localized: String  {
        return NSLocalizedString(self, comment: "")
    }
    
    var htmlToString: String {
        let font = UIFont(name: "Avenir", size: 14)
        let textColor = UIColor(named: "OnBackGroundColor")
        let linkColor = UIColor(named: "AccentColor")
        return htmlToAttributedString(font: font ?? .systemFont(ofSize: 12),
                                      textColor: textColor ?? .white,
                                      linkColor: linkColor ?? .link)?.string ?? ""
    }
    
    func htmlToAttributedString(font: UIFont, textColor: UIColor, linkColor: UIColor) -> NSAttributedString? {
        return NSAttributedString(html: self, font: font, textColor: textColor, linkColor: linkColor)
    }
    
    func formatToTwoDecimal() -> String? {
        guard let value = Double(self) else { return nil }
        return String(format: "%.2f", value)
    }
}
