//
//  MatchTableViewCell.swift
//  Sports
//
//  Created by ios Dev on 10/05/2024.
//

import UIKit

class MatchTableViewCell: UITableViewCell, MatchCellProtocol {
    
    // MARK: - Properties
    private var countdownTimer: CountdownTimer?

    // MARK: - Outlets
    @IBOutlet weak var homeTeamNameLabel: UILabel!
    @IBOutlet weak var awayTeamNameLabel: UILabel!

    @IBOutlet weak var matchTimeLabel: UILabel!
    
    @IBOutlet weak var homeTeamImage: UIImageView!
    @IBOutlet weak var awayTeamImage: UIImageView!
        
    @IBOutlet weak var liveImageContentView: UIView!
    @IBOutlet weak var liveMatchAnimationImage: UIImageView!
    @IBOutlet weak var liveMatchTimeLabel: UILabel!
    
    // MARK: - Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    // MARK: - Methods
    func configureMatchCellUI(match: Match?) {
        homeTeamNameLabel.text = match?.details?.homeTeamDetail?.name ?? "N/A".localized
        awayTeamNameLabel.text = match?.details?.awayTeamDetail?.name ?? "N/A".localized
                
        let homeTeamLogoUrl = URL(string: match?.details?.homeTeamDetail?.logo ?? "")
        homeTeamImage.setImageWithSkeleton(with: homeTeamLogoUrl)
        
        let awayTeamLogoUrl = URL(string: match?.details?.awayTeamDetail?.logo ?? "")
        awayTeamImage.setImageWithSkeleton(with: awayTeamLogoUrl)
    }
    
    func configureLiveMatchCellUI(matchStatus: MatchStatus?, match: Match?) {
        guard let status = matchStatus, let match = match else { return }
        switch status {
        case .abnormal:
            setNormalMatch(matchTime: "There is Some abnormal Thing Happened".localized)
        case .notStarted:
            setNormalMatch(matchTime: match.details?.matchDetails?.matchTime?.toDateString() ?? "")
        case .sectionOne:
            setLiveUI(with: match.details?.matchDetails?.periodCount?.description ?? "", quarterLeftTime: match.score?[2], homeScore: match.score, awayScore: match.score)
        case .sectionOneOver:
            setPauseUI(with: match.details?.matchDetails?.periodCount?.description ?? "")
        case .sectionTwo:
            setLiveUI(with: match.details?.matchDetails?.periodCount?.description ?? "", quarterLeftTime: match.score?[2], homeScore: match.score, awayScore: match.score)
        case .sectionTwoOver:
            setPauseUI(with: match.details?.matchDetails?.periodCount?.description ?? "")
        case .sectionThree:
            setLiveUI(with: match.details?.matchDetails?.periodCount?.description ?? "", quarterLeftTime: match.score?[2], homeScore: match.score, awayScore: match.score)
        case .sectionThreeOver:
            setPauseUI(with: match.details?.matchDetails?.periodCount?.description ?? "")
        case .sectionFour:
            setLiveUI(with: match.details?.matchDetails?.periodCount?.description ?? "", quarterLeftTime: match.score?[2], homeScore: match.score, awayScore: match.score)
        case .overtime:
            setPauseUI(with: match.details?.matchDetails?.periodCount?.description ?? "")
        case .end:
            setNormalMatch(matchTime: "Match Ended".localized)
        case .interrupt:
            setNormalMatch(matchTime: "Match Interrupted".localized)
        case .cancel:
            setNormalMatch(matchTime: "Match Canceled".localized)
        case .extensions:
            setNormalMatch(matchTime: "Waiting For Extended Date".localized)
        case .cutInHalf:
            setNormalMatch(matchTime: "Cutes Time".localized)
        case .toBeDetermined:
            setNormalMatch(matchTime: "Time to BeDetermined".localized)
        }
    }
    
    fileprivate func setLiveUI(with quarterNumber: String, quarterLeftTime: Score?, homeScore: [Score]?, awayScore: [Score]?) {
        var leftTime: Int = 0
        var homeScoreValue: String = "0"
        var awayScoreValue: String = "0"

        
        switch quarterLeftTime {
        case .integer(let seconds):
            leftTime = seconds
        case .string(let seconds):
            leftTime = Int(seconds) ?? 0
        case .integerArray(let seconds):
            leftTime = seconds[0]
        case .none:
            break
        }
        
        liveMatchAnimationImage.image = UIImage(systemName: "livephoto")
        configure(seconds: leftTime, quarter: "Q " + quarterNumber)
        if #available(iOS 17.0, *) {
            configureImage()
        } else {
            // Fallback on earlier versions
        }
        
        switch homeScore?[3] {
        case .integer(let score):
            homeScoreValue = score.description
        case .string(let score):
            homeScoreValue = score
        case .integerArray(let score):
            homeScoreValue = score[0].description
        case .none:
            break
        }
        
        switch awayScore?[3] {
        case .integer(let score):
            awayScoreValue = score.description
        case .string(let score):
            awayScoreValue = score
        case .integerArray(let score):
            awayScoreValue = score[1].description
        case .none:
            break
        }
        
        liveMatchTimeLabel.text = homeScoreValue + " - " + awayScoreValue
    }
    
    fileprivate func setPauseUI(with quarterNumber: String) {
        liveMatchAnimationImage.image = UIImage(systemName: "livephoto")
        if #available(iOS 17.0, *) {
            configurePauseImage()
        } else {
            // Fallback on earlier versions
        }
    }
    
    fileprivate func setOverTimeUI(with quarterNumber: String) {
        liveMatchAnimationImage.image = UIImage(systemName: "livephoto")
        if #available(iOS 17.0, *) {
            configurePauseImage()
        } else {
            // Fallback on earlier versions
        }
    }
    
    fileprivate func setNormalMatch(matchTime: String) {
        matchTimeLabel.text = matchTime
        liveImageContentView.isHidden = true
        liveMatchTimeLabel.isHidden = true
    }
    
    @available(iOS 17.0, *)
    private func configureImage() {
        liveImageContentView.isHidden = false
        liveMatchTimeLabel.isHidden = false
        liveMatchAnimationImage.addSymbolEffect(.pulse.byLayer)
    }
    
    @available(iOS 17.0, *)
    private func configurePauseImage() {
        liveImageContentView.isHidden = false
        liveMatchTimeLabel.isHidden = false
        liveMatchAnimationImage.addSymbolEffect(.scale.byLayer)
    }
     
    func configure(seconds: Int, quarter: String) {
//        countdownTimer?.startCountdown() // Stop any existing timer
        countdownTimer = CountdownTimer(seconds: seconds) { [weak self] formattedTime in
            DispatchQueue.main.async {
                self?.matchTimeLabel.text = quarter + " - " + formattedTime
            }
        }
        countdownTimer?.startCountdown()
    }
    
}
