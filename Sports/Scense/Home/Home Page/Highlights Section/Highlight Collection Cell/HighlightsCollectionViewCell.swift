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
    
    func configureCell(with highlight: HighlightsNews) {
        
        var appendURL = ""
        let details = highlight.detail ?? ""

        details == "#" ? (appendURL = "https://sportsapi3.com/hotnews/") : ()
        loadCellImages(loadImage: highlightImage, from: appendURL + (highlight.thumbnail ?? ""))
        
        highlightTitleLabel.text = highlight.headline ?? ""
        highlightTitleLabel.isHidden = (details == "#")
    }
}
