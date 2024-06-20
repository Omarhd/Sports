//
//  DateFilterCollectionViewCell.swift
//  Sports
//
//  Created by ios Dev on 19/06/2024.
//

import UIKit

class DateFilterCollectionViewCell: UICollectionViewCell, DateFilterCellProtocol {
    
    // MARK: - Outlets
    @IBOutlet weak var currentDateTitleLabel: UILabel!
    @IBOutlet weak var selectionView: UIView!
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionView.isHidden = true // Initially hidden
    }
    
    // MARK: - Methods
    func configureFilter(date: DateModel) {
        self.currentDateTitleLabel.text = date.formattedString
        self.selectionView.isHidden = !isSelected
    }
}
