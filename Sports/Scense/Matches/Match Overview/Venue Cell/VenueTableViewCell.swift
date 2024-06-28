//
//  VenueTableViewCell.swift
//  Sports
//
//  Created by ios Dev on 25/06/2024.
//

import UIKit

class VenueTableViewCell: UITableViewCell, VenueCellCellProtocol {

    // MARK: - Outlets
    @IBOutlet weak var venueNameLabel: UILabel!
    @IBOutlet weak var venueCapacityLabel: UILabel!
    @IBOutlet weak var venueCityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellUI(venue: VenueDetails?) {
        venueNameLabel.text = venue?.name
        venueCapacityLabel.text = venue?.capacity?.description
        venueCityLabel.text = venue?.city
    }
    
}
