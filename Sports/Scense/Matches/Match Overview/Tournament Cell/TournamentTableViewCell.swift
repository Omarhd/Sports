//
//  TournamentTableViewCell.swift
//  Sports
//
//  Created by ios Dev on 25/06/2024.
//

import UIKit
import Kingfisher

class TournamentTableViewCell: UITableViewCell, TournamentCellCellProtocol {

    // MARK: - Outlets
    @IBOutlet weak var tournamentNameLabel: UILabel!
    @IBOutlet weak var tournamentTypeLabel: UILabel!
    @IBOutlet weak var tournamentShortNameLabel: UILabel!
    @IBOutlet weak var tournamentLogo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellUI(tournament: TournamentDetails?) {
        tournamentNameLabel.text = tournament?.name
        tournamentShortNameLabel.text = tournament?.shortName
        loadCellImages(loadImage: tournamentLogo, from: tournament?.logo)

        switch tournament?.type {
        case .unknown: tournamentTypeLabel.text = "Unknown".localized
        case .league: tournamentTypeLabel.text = "League".localized
        case .cup: tournamentTypeLabel.text = "Cup".localized
        case nil: tournamentTypeLabel.text = "N/A".localized
        }
    }
    
}
