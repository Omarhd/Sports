//
//  MatchH2HTableViewCell.swift
//  Sports
//
//  Created by ios Dev on 25/06/2024.
//

import UIKit

class MatchH2HTableViewCell: UITableViewCell, MatchH2HCellProtocol {

    @IBOutlet weak var homeTeamImage: UIImageView!
    @IBOutlet weak var awayTeamImage: UIImageView!
    
    @IBOutlet weak var homeTeamNameLabel: UILabel!
    @IBOutlet weak var awayTeamNameLabel: UILabel!
    
    @IBOutlet weak var homeTotalPointsLabel: UILabel!
    @IBOutlet weak var homeTeamFirstQuarterPointsLabel: UILabel!
    @IBOutlet weak var homeTeamSecondQuarterPointsLabel: UILabel!
    @IBOutlet weak var homeTeamThirdQuarterPointsLabel: UILabel!
    @IBOutlet weak var homeTeamFourthQuarterPointsLabel: UILabel!
    
    @IBOutlet weak var awayTotalPointsLabel: UILabel!
    @IBOutlet weak var awayTeamFirstQuarterPointsLabel: UILabel!
    @IBOutlet weak var awayTeamSecondQuarterPointsLabel: UILabel!
    @IBOutlet weak var awayTeamThirdQuarterPointsLabel: UILabel!
    @IBOutlet weak var awayTeamFourthQuarterPointsLabel: UILabel!
    
    @IBOutlet weak var homeTeamScoreView: UIView!
    @IBOutlet weak var awayTeamScoreView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with match: H2HMatch?) {
        homeTeamNameLabel.text = match?.homeTeamDetail?.name
        awayTeamNameLabel.text = match?.awayTeamDetail?.name
        
        let homeTeamLogoUrl = match?.homeTeamDetail?.logo
        loadImages(loadImage: homeTeamImage, from: homeTeamLogoUrl)
        
        let awayTeamLogoUrl = match?.awayTeamDetail?.logo
        loadImages(loadImage: awayTeamImage, from: awayTeamLogoUrl)
        
        let homeTeamFinalScore = totalPoints(match?.the6 ?? [])
        let homeQuarterOneScore = scoreToInt(match?.the6?[2])
        let homeQuarterTowScore = scoreToInt(match?.the6?[3])
        let homeQuarterThreeScore = scoreToInt(match?.the6?[4])
        let homeQuarterFourScore = scoreToInt(match?.the6?[5])
        
        homeTotalPointsLabel.text = homeTeamFinalScore.description
        homeTeamFirstQuarterPointsLabel.text = homeQuarterOneScore?.description ?? "-"
        homeTeamSecondQuarterPointsLabel.text = homeQuarterTowScore?.description ?? "-"
        homeTeamThirdQuarterPointsLabel.text = homeQuarterThreeScore?.description ?? "-"
        homeTeamFourthQuarterPointsLabel.text = homeQuarterFourScore?.description ?? "-"

        let awayTeamFinalScore = totalPoints(match?.the7 ?? [])
        let awayQuarterOneScore = scoreToInt(match?.the7?[2])
        let awayQuarterTowScore = scoreToInt(match?.the7?[3])
        let awayQuarterThreeScore = scoreToInt(match?.the7?[4])
        let awayQuarterFourScore = scoreToInt(match?.the7?[5])
        
        awayTotalPointsLabel.text = awayTeamFinalScore.description
        awayTeamFirstQuarterPointsLabel.text = awayQuarterOneScore?.description ?? "-"
        awayTeamSecondQuarterPointsLabel.text = awayQuarterTowScore?.description ?? "-"
        awayTeamThirdQuarterPointsLabel.text = awayQuarterThreeScore?.description ?? "-"
        awayTeamFourthQuarterPointsLabel.text = awayQuarterFourScore?.description ?? "-"
        
        homeTeamFinalScore > awayTeamFinalScore ? setWhenHomeTeamStatBigger() : setWhenAwayTeamStatBigger()
    }
    
    func scoreToInt(_ score: The6_Element?) -> Int? {
        switch score {
        case .integer(let intValue):
            return intValue
        case .string(_):
            return nil
        case .none:
            return nil
        }
    }
    
    func totalPoints(_ scores: [The6_Element]) -> Int {
        var finalScore: Int = 0
        for score in scores {
            switch score {
            case .integer(let intValue):
                finalScore += intValue
            case .string(_):
                break
            }
        }
        return finalScore
    }
    
    func setWhenHomeTeamStatBigger() {
        homeTeamScoreView.backgroundColor = .accent
        homeTotalPointsLabel.textColor = .white
        
        awayTeamScoreView.backgroundColor = .clear
        awayTotalPointsLabel.textColor = .label
    }
    
    func setWhenAwayTeamStatBigger() {
        awayTeamScoreView.backgroundColor = .accent
        awayTotalPointsLabel.textColor = .white
        
        homeTeamScoreView.backgroundColor = .clear
        homeTotalPointsLabel.textColor = .label
    }
}
