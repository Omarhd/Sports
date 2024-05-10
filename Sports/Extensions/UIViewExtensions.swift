//
//  UIViewExtensions.swift
//  ChatApp
//
//  Created by ios Dev on 06/05/2024.
//

import UIKit

extension UIView {
    // MARK: - View Identifier
    public static func viewIdentifier() -> String {
        return String(describing: self)
    }
    // MARK: - Convert to UIImage
    func asImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isHidden, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }

        return nil
    }
}
