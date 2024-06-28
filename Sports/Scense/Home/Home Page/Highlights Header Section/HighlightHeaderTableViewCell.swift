//
//  HighlightHeaderTableViewCell.swift
//  Sports
//
//  Created by ios Dev on 27/06/2024.
//

import UIKit

class HighlightHeaderTableViewCell: UITableViewCell, HighlightsHeaderViewCellProtocols {

    @IBOutlet weak var headerTitleViewLabel: UILabel!
    @IBOutlet weak var headerSeeAllButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func seeAllAction(_ sender: Any) {
    }
    
    func configureCell(title: String, isSeeAllEnabled: Bool) {
        headerTitleViewLabel.text = title
        isSeeAllEnabled ? (headerSeeAllButton.isHidden = true) : (headerSeeAllButton.isHidden = false)
    }
}
