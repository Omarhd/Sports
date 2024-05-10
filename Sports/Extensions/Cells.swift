//
//  Cells.swift
//  Sports
//
//  Created by ios Dev on 10/05/2024.
//

import UIKit

extension UITableViewCell {
    
    // MARK: - func of load images wit kingfisher
    func loadCellImages(loadImage: UIImageView, imgURL: String) {
        if imgURL != "" {
            //...load real img
            loadImage.kf.indicatorType = .activity
            let url = URL(string: imgURL)
            loadImage.kf.setImage(with: url)
        }else{
            loadImage.image = UIImage(systemName: "soccerball.circle.fill")
        }
    }
}

extension UICollectionViewCell {
    // MARK: - func of load images wit kingfisher
    func loadCellImages(loadImage: UIImageView, imgURL: String) {
        if imgURL != "" {
            //...load real img
            loadImage.kf.indicatorType = .activity
            let url = URL(string: imgURL)
            loadImage.kf.setImage(with: url)
        }else{
            loadImage.image = UIImage(systemName: "soccerball.circle.fill")
        }
    }
    
}
