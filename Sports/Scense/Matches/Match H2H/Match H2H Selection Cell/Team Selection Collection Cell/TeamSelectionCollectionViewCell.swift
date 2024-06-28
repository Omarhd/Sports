//
//  TeamSelectionCollectionViewCell.swift
//  Sports
//
//  Created by ios Dev on 25/06/2024.
//

import UIKit

class TeamSelectionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var selectionTitleLabel: UILabel!
    @IBOutlet weak var selectionView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(with title: String) {
        selectionTitleLabel.text = title
        isSelected ? setSelectedUI() : setDefaultUI()
    }
    
    fileprivate func setSelectedUI() {
        selectionTitleLabel.textColor = .label
        selectionView.backgroundColor = .accent
        selectionView.layer.cornerRadius = 12
    }
    
    fileprivate func setDefaultUI() {
        selectionTitleLabel.textColor = .lightGray
        selectionView.backgroundColor = .cell
    }
}
