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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func displayName(name: String) {
        titleLabel.text = name
    }
    
}
