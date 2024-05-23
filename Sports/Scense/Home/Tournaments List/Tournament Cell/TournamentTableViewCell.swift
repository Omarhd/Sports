//
//  TournamentTableViewCell.swift
//  Sports
//
//  Created by ios Dev on 10/05/2024.
//

import UIKit

class TournamentTableViewCell: UITableViewCell, TournamentCellProtocol {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCellUI(tournament: Tournament) {
        titleLabel.text = tournament.name
    }
    
}
