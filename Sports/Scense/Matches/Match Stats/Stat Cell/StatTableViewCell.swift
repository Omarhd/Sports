//
//  StatTableViewCell.swift
//  Sports
//
//  Created by ios Dev on 25/06/2024.
//

import UIKit

class StatTableViewCell: UITableViewCell, StatCellProtocol {

    @IBOutlet weak var homeTeamScoreView: UIView!
    @IBOutlet weak var awayTeamScoreView: UIView!
    
    @IBOutlet weak var homeTeamStatLabel: UILabel!
    @IBOutlet weak var awayTeamStatLabel: UILabel!
    @IBOutlet weak var statTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with stats: [Double]) {
        homeTeamStatLabel.text = stats[1].description
        awayTeamStatLabel.text = stats[2].description
        statTitleLabel.text = getStatTitleForBasketball(for: Int(stats[0]))
        
        stats[1] > stats[2] ? (setWhenHomeTeamStatBigger()) : (setWhenAwayTeamStatBigger())
    }
    
    func setWhenHomeTeamStatBigger() {
        homeTeamScoreView.backgroundColor = .accent
        homeTeamStatLabel.textColor = .white
        
        awayTeamScoreView.backgroundColor = .clear
        awayTeamStatLabel.textColor = .label
    }
    
    func setWhenAwayTeamStatBigger() {
        awayTeamScoreView.backgroundColor = .accent
        awayTeamStatLabel.textColor = .white
        
        homeTeamScoreView.backgroundColor = .clear
        homeTeamStatLabel.textColor = .label
    }
   
    func getStatTitleForBasketball(for value: Int) -> String {
        guard let statCode = StatBasketballTitle(rawValue: value) else { return "N/A".localized }
        
        switch statCode {
        case .pointGoals:
            return "3-point goals".localized
            
        case .twoPointGoals:
            return "2-point goals".localized

        case .FreeThrowGoals:
            return "Free throw goals".localized

        case .NumberOfPausesRemaining:
            return "Number of pauses remaining".localized

        case .fouls:
            return "Fouls".localized

        case .freeThrowPercentage:
            return "Free throw percentage".localized

        case .totalPauses:
            return "Total pauses".localized
        }
    }
}
