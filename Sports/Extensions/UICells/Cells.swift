//
//  Cells.swift
//  Sports
//
//  Created by ios Dev on 10/05/2024.
//

import UIKit

extension UITableViewCell {
    
    // MARK: - func of load images wit kingfisher
    func loadCellImages(loadImage: UIImageView, from imagePathURL: String?) {
        loadImage.kf.indicatorType = .custom(indicator: SkeletonIndicator())
        if let imagePathURL = imagePathURL, let url = URL(string: imagePathURL) {
            loadImage.kf.setImage(with: url)
        } else {
            loadImage.image = UIImage(systemName: "basketball.fill")
        }
    }
}

extension UICollectionViewCell {
    // MARK: - func of load images wit kingfisher
    func loadCellImages(loadImage: UIImageView, from imagePathURL: String?) {
        loadImage.kf.indicatorType = .custom(indicator: SkeletonIndicator())
        if let imagePathURL = imagePathURL, let url = URL(string: imagePathURL) {
            loadImage.kf.setImage(with: url)
        } else {
            loadImage.image = UIImage(systemName: "basketball.fill")
        }
    }
}
