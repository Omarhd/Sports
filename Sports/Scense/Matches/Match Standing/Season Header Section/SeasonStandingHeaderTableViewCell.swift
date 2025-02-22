//
//  SeasonStandingHeaderTableViewCell.swift
//  Sports
//
//  Created by ios Dev on 26/06/2024.
//

import UIKit

class SeasonStandingHeaderTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var teamAveragePointCountLabel: UILabel!
    @IBOutlet weak var teamAverageAgainstPointsLabel: UILabel!
    @IBOutlet weak var last10MatchesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
