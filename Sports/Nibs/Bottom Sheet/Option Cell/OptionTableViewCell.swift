//
//  OptionTableViewCell.swift
//  Sports
//
//  Created by ios Dev on 27/06/2024.
//

import UIKit

class OptionTableViewCell: UITableViewCell, OptionsCellProtocol {

    // MARK: - Outlets
    @IBOutlet weak var optionTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with title: String) {
        optionTitleLabel.text = title
    }
    
}
