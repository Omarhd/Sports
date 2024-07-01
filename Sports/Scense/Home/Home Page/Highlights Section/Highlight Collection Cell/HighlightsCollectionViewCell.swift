//
//  HighlightsCollectionViewCell.swift
//  Sports
//
//  Created by ios Dev on 27/06/2024.
//

import UIKit
import Kingfisher

class HighlightsCollectionViewCell: UICollectionViewCell, highlightCollectionCellProtocol {

    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var highlightImage: UIImageView!
    @IBOutlet weak var highlightTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.cornerRadius = 16
    }
    
    func configureCell(with highlight: HomeHighlightsEntity) {
        highlightTitleLabel.text = highlight.title
        loadCellImages(loadImage: highlightImage, from: highlight.imageURL)
    }

}
