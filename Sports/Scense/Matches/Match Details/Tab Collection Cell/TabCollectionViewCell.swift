//
//  TabCollectionViewCell.swift
//  Sports
//
//  Created by ios Dev on 24/06/2024.
//

import UIKit

class TabCollectionViewCell: UICollectionViewCell, TabCellProtocol {
    
    @IBOutlet weak var tabTitleLabel: UILabel!
    @IBOutlet weak var selectionView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureTab(tab: String) {
        print(tab)
        tabTitleLabel.text = tab
        isSelected ? (tabTitleLabel.textColor = .label) : (tabTitleLabel.textColor = .lightGray)
        isSelected ? (selectionView.backgroundColor = .accent) : (selectionView.backgroundColor = .clear)
    }
}
