//
//  VideoTableViewCell.swift
//  Sports
//
//  Created by ios Dev on 29/06/2024.
//

import UIKit
import AVKit

class VideoTableViewCell: UITableViewCell, VideoPlayerCellProtocol {
    
    @IBOutlet weak var interactionsView: UIView!
    @IBOutlet weak var videoThumbnailImage: UIImageView!
    @IBOutlet weak var videoContentView: UIView!
    
    @IBOutlet weak var likeButton: UIButton!
    
    private var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var index: Int = 0
    var delegate: VideoPlayerCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadCellImages(loadImage: videoThumbnailImage, from: "https://static-cse.canva.com/blob/1577482/1600w-wK95f3XNRaM.jpg")
        setupTapGesture()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        player?.pause()
        player = nil
        playerLayer?.removeFromSuperlayer()
    }
    
    func configureCell(with url: URL) {
        let asset = AVURLAsset(url: url)
        let item = AVPlayerItem(asset: asset)
        
        player = AVPlayer(playerItem: item)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.videoGravity = .resizeAspectFill
        playerLayer?.frame = self.bounds
        videoContentView.layer.addSublayer(playerLayer!)
        videoThumbnailImage.isHidden = true
        
        player?.currentItem?.addObserver(self, forKeyPath: PlayerStatusKeyPath.status.rawValue, options: [.old, .new], context: nil)
        player?.currentItem?.addObserver(self, forKeyPath: PlayerStatusKeyPath.playbackLikelyToKeepUp.rawValue, options: [.old, .new], context: nil)
    
        player?.play()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let playerItem = object as? AVPlayerItem, let keyPath = keyPath, let statusKeyPath = PlayerStatusKeyPath(rawValue: keyPath) else { return }
        
        switch statusKeyPath {
        case .status:
            if playerItem.status == .readyToPlay {
                print("Ready to play")
            } else if playerItem.status == .failed {
                print("Failed to load")
            }
        case .playbackLikelyToKeepUp:
            if playerItem.isPlaybackLikelyToKeepUp {
                player?.play()
            } else {
                print("Buffering")
            }
        case .playbackBufferEmpty:
            print("Buffer empty")
        }
    }
    
    deinit {
        player?.currentItem?.removeObserver(self, forKeyPath: PlayerStatusKeyPath.status.rawValue)
        player?.currentItem?.removeObserver(self, forKeyPath: PlayerStatusKeyPath.playbackLikelyToKeepUp.rawValue)
    }
    
    @objc private func videoDidFinish() {
        delegate?.videoDidFinishPlaying(in: self)
    }
    
    
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.numberOfTapsRequired = 1
        contentView.addGestureRecognizer(tapGesture)
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        contentView.addGestureRecognizer(doubleTapGesture)
        
        tapGesture.require(toFail: doubleTapGesture)
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        if let player = player {
            if player.rate != 0 && player.error == nil {
                player.pause()
            } else {
                player.play()
            }
        }
    }
    
    @objc func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
        showLikeLottieLoader()
    }
    
    @IBAction func likeAction(_ sender: Any) {
        showLikeLottieLoader()
    }
    
}
