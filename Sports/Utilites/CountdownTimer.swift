//
//  CountdownTimer.swift
//  Sports
//
//  Created by ios Dev on 22/06/2024.
//

import Foundation

class CountdownTimer {
    
    private var totalTime: Int
    private var timer: Timer?
    private var timeRemaining: Int
    private var updateCallback: ((String) -> Void)?

    init(seconds: Int, updateCallback: @escaping (String) -> Void) {
        self.totalTime = seconds
        self.timeRemaining = seconds
        self.updateCallback = updateCallback
    }
    
    func startCountdown() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTime() {
        if timeRemaining > 0 {
            timeRemaining -= 1
            updateCallback?(formatTime(seconds: timeRemaining))
        } else {
            timer?.invalidate()
            timer = nil
            updateCallback?("0:00")
        }
    }
    
    private func formatTime(seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%d:%02d", minutes, remainingSeconds)
    }
}
