//
//  MatchTableViewCell.swift
//  Sports
//
//  Created by ios Dev on 10/05/2024.
//

import UIKit

class MatchTableViewCell: UITableViewCell, MatchCellProtocol {

    @IBOutlet weak var homeTeamNameLabel: UILabel!
    @IBOutlet weak var awayTeamNameLabel: UILabel!

    @IBOutlet weak var matchTimeLabel: UILabel!
    
    @IBOutlet weak var homeTeamImage: UIImageView!
    @IBOutlet weak var awayTeamImage: UIImageView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCellUI(match: Match?) {
        homeTeamNameLabel.text = match?.details?.homeTeamDetail?.name
        awayTeamNameLabel.text = match?.details?.awayTeamDetail?.name
        
        let homeTeamLogoUrl = URL(string: match?.details?.homeTeamDetail?.logo ?? "")
        homeTeamImage.kf.setImage(with: homeTeamLogoUrl)
        
        let awayTeamLogoUrl = URL(string: match?.details?.awayTeamDetail?.logo ?? "")
        awayTeamImage.kf.setImage(with: awayTeamLogoUrl)

    }
    
}
