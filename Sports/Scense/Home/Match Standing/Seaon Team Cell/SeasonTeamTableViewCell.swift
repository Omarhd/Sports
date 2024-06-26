//
//  SeasonTeamTableViewCell.swift
//  Sports
//
//  Created by ios Dev on 26/06/2024.
//

import UIKit

class SeasonTeamTableViewCell: UITableViewCell, SeasonTeamCellProtocol {

    @IBOutlet weak var teamPositionLabel: UILabel!
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamWonCountLabel: UILabel!
    @IBOutlet weak var teamLostCountLabel: UILabel!
    @IBOutlet weak var teamAveragePointCountLabel: UILabel!
    @IBOutlet weak var teamDeffAverageCountLabel: UILabel!
    @IBOutlet weak var last10MatchesLabel: UILabel!
    @IBOutlet weak var divisionLabel: UILabel!
    @IBOutlet weak var teamAverageAgainstPointsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with team: StandingsData?) {
        teamPositionLabel.text = team?.position?.description
        teamNameLabel.text = team?.teamInfo?.name
        teamWonCountLabel.text = team?.won?.description
        teamLostCountLabel.text = team?.lost?.description
        teamAveragePointCountLabel.text = team?.pointsAvg?.description
        teamDeffAverageCountLabel.text = team?.diffAvg?.description
        last10MatchesLabel.text = team?.last10
        divisionLabel.text = team?.division
        teamAverageAgainstPointsLabel.text = team?.pointsAgainstAvg?.description
        
        let teamLogoUrl = URL(string: team?.teamInfo?.logo ?? "")
        teamImage.setImageWithSkeleton(with: teamLogoUrl)
    }
    
}
