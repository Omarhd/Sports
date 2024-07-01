//
//  VideoPlayerManager.swift
//  Sports
//
//  Created by ios Dev on 29/06/2024.
//

import AVFoundation

protocol VideoPlayerManagerDelegate: AnyObject {
    func videoPlayerManager(_ manager: VideoPlayerManager, didChangeStateTo state: VideoPlayerState)
    func videoPlayerManager(_ manager: VideoPlayerManager, didEncounterError error: Error?)
}

enum VideoPlayerState {
    case playing
    case paused
    case stopped
    case buffering
    case ended
    case failed
}

class VideoPlayerManager: NSObject {
    private var player: AVPlayer?
    private var playerItem: AVPlayerItem?
    weak var delegate: VideoPlayerManagerDelegate?
    
    override init() {
        super.init()
    }
    
    func playVideo(from url: URL) {
        playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        
        player?.addObserver(self, forKeyPath: #keyPath(AVPlayer.status), options: [.new], context: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying(_:)), name: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
        
        player?.play()
        delegate?.videoPlayerManager(self, didChangeStateTo: .playing)
    }
    
    func pause() {
        player?.pause()
        delegate?.videoPlayerManager(self, didChangeStateTo: .paused)
    }
    
    func stop() {
        player?.pause()
        player?.seek(to: .zero)
        delegate?.videoPlayerManager(self, didChangeStateTo: .stopped)
    }
    
    func seek(to time: CMTime) {
        player?.seek(to: time)
    }
    
    @objc private func playerDidFinishPlaying(_ notification: Notification) {
        delegate?.videoPlayerManager(self, didChangeStateTo: .ended)
    }
    
    deinit {
        player?.removeObserver(self, forKeyPath: #keyPath(AVPlayer.status))
        NotificationCenter.default.removeObserver(self)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard keyPath == #keyPath(AVPlayer.status) else { return }
        
        if let statusInt = change?[.newKey] as? Int,
           let status = AVPlayer.Status(rawValue: statusInt) {
            switch status {
            case .readyToPlay:
                delegate?.videoPlayerManager(self, didChangeStateTo: .playing)
            case .failed:
                delegate?.videoPlayerManager(self, didChangeStateTo: .failed)
                if let error = player?.error {
                    delegate?.videoPlayerManager(self, didEncounterError: error)
                }
            case .unknown:
                delegate?.videoPlayerManager(self, didChangeStateTo: .failed)
            @unknown default:
                delegate?.videoPlayerManager(self, didChangeStateTo: .failed)
            }
        }
    }
}
