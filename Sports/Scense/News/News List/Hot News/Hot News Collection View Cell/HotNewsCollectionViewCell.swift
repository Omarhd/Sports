//
//  HotNewsCollectionViewCell.swift
//  Sports
//
//  Created by ios Dev on 11/06/2024.
//

import UIKit

class HotNewsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var hotNewsImage: UIImageView!
    @IBOutlet weak var hotNewsTitleLabel: UILabel!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(with news: News?) {
        hotNewsTitleLabel.text = news?.title?.htmlToString
        loadCellImages(loadImage: hotNewsImage, from: news?.path)
    }

}
