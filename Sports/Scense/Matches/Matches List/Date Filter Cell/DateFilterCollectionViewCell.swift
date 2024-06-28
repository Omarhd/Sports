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
    @IBOutlet weak var underLineView: UIView!
    
    // MARK: - Properties
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Methods
    func configureFilter(date: DateModel) {
        self.currentDateTitleLabel.text = date.formattedString
        isSelected ? (currentDateTitleLabel.textColor = .label) : (currentDateTitleLabel.textColor = .lightGray)
        isSelected ? (underLineView.backgroundColor = .accent) : (underLineView.backgroundColor = .clear)
    }
}
