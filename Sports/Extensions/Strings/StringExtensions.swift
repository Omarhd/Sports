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
    
    func toURL() -> URL? {
        guard let encodedString = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }        
        return URL(string: encodedString)
    }
    
    var isValidURL: Bool {
        guard !self.isEmpty else { return false }
        if let url = URL(string: self) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
    var isValidEmail: Bool {
        let emailRegEx = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        return self.count >= 8
    }
    
    var isNotEmpty: Bool {
        return !isEmpty
    }

}
