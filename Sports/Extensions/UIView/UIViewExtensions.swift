//
//  UIViewExtensions.swift
//  ChatApp
//
//  Created by ios Dev on 06/05/2024.
//

import UIKit
import Kingfisher

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
    
    // MARK: - func of load images wit kingfisher
    func loadImages(loadImage: UIImageView, from imagePathURL: String?) {
        if let imagePathURL = imagePathURL, let url = URL(string: imagePathURL) {
            loadImage.kf.indicatorType = .custom(indicator: SkeletonIndicator())
            loadImage.kf.setImage(with: url)
        } else {
            loadImage.image = UIImage(systemName: "basketball.fill")
        }
    }
}

