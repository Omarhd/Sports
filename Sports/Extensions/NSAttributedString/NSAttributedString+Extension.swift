//
//  NSAttributedString+Extension.swift
//  Sports
//
//  Created by ios Dev on 11/06/2024.
//

import UIKit

extension NSAttributedString {
    
    convenience init?(html: String, font: UIFont, textColor: UIColor, linkColor: UIColor) {
        guard let data = html.data(using: .utf8) else { return nil }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSMutableAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }
        
        // Apply custom font and text color
        let fullRange = NSRange(location: 0, length: attributedString.length)
        attributedString.addAttribute(.font, value: font, range: fullRange)
        attributedString.addAttribute(.foregroundColor, value: textColor, range: fullRange)
        
        // Apply custom link color
        attributedString.enumerateAttribute(.link, in: fullRange, options: []) { value, range, _ in
            if value != nil {
                attributedString.addAttribute(.foregroundColor, value: linkColor, range: range)
            }
        }
        
        self.init(attributedString: attributedString)
    }
    
}
