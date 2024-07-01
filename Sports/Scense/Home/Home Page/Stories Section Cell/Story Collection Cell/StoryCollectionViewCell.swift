//
//  StoryCollectionViewCell.swift
//  Sports
//
//  Created by ios Dev on 27/06/2024.
//

import UIKit

class StoryCollectionViewCell: UICollectionViewCell, StoriesCollectionCellProtocol {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.borderColor = UIColor.accent.cgColor
        containerView.layer.borderWidth = 0.8
        containerView.layer.cornerRadius = 25
    }

    func configureCell(with story: HomeStoryEntity) {
        userNameLabel.text = story.name
        loadCellImages(loadImage: userImage, from: story.imageURL)
    }
}
