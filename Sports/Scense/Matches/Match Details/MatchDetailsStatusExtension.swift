//
//  MatchDetailsStatusExtension.swift
//  Sports
//
//  Created by ios Dev on 01/07/2024.
//

import UIKit

extension MatchDetailsViewController {
    
    func setLiveUI(with quarterNumber: String, quarterLeftTime: Score?, homeScore: [Score]?, awayScore: [Score]?) {
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
    
    func setPauseUI(with quarterNumber: String) {
        liveMatchAnimationImage.image = UIImage(systemName: "livephoto")
        if #available(iOS 17.0, *) {
            configurePauseImage()
        } else {
            // Fallback on earlier versions
        }
    }
    
    func setOverTimeUI(with quarterNumber: String) {
        liveMatchAnimationImage.image = UIImage(systemName: "livephoto")
        if #available(iOS 17.0, *) {
            configurePauseImage()
        } else {
            // Fallback on earlier versions
        }
    }
    
    func setNormalMatch(matchTime: String) {
        matchTimeLabel.text = matchTime
        liveImageContentView.isHidden = true
        liveMatchTimeLabel.isHidden = true
    }
    
    @available(iOS 17.0, *)
    func configureImage() {
        liveImageContentView.isHidden = false
        liveMatchTimeLabel.isHidden = false
        liveMatchAnimationImage.addSymbolEffect(.pulse.byLayer)
    }
    
    @available(iOS 17.0, *)
    func configurePauseImage() {
        liveImageContentView.isHidden = false
        liveMatchTimeLabel.isHidden = false
        liveMatchAnimationImage.addSymbolEffect(.scale.byLayer)
    }
    
    func configure(seconds: Int, quarter: String) {
        countdownTimer?.stopCountdown() // Stop any existing timer
        countdownTimer = CountdownTimer(
            seconds: seconds,
            updateCallback: { [weak self] formattedTime in
                DispatchQueue.main.async {
                    self?.matchTimeLabel.text = quarter + " - " + formattedTime
                }
            },
            completionCallback: { [weak self] in
                DispatchQueue.main.async {
                    self?.matchTimeLabel.text = quarter + " - Time's up!"
                }
            }
        )
        countdownTimer?.startCountdown()
    }
}
