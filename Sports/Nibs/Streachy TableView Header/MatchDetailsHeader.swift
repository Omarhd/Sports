//
//  MatchDetailsHeader.swift
//  Sports
//
//  Created by ios Dev on 22/06/2024.
//

import UIKit
import Kingfisher

class MatchDetailsHeader: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak private var homeTeamImage: UIImageView!
    @IBOutlet weak private var awayTeamImage: UIImageView!
    @IBOutlet weak private var matchScore: UILabel!

    var match: Match? { didSet { setupUI() } }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNIb()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNIb()
        setupUI()
    }
    
    private func setupUI() {
        let homeTeamLogoUrl = URL(string: match?.details?.homeTeamDetail?.logo ?? "")
        homeTeamImage.setImageWithSkeleton(with: homeTeamLogoUrl)
        
        let awayTeamLogoUrl = URL(string: match?.details?.awayTeamDetail?.logo ?? "")
        awayTeamImage.setImageWithSkeleton(with: awayTeamLogoUrl)

        matchScore.text = "0 - 0"
    }
    
    fileprivate func loadNIb() {
        Bundle.main.loadNibNamed("MatchDetailsHeader", owner: self, options: nil)
        self.tag = 100
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask  = [.flexibleHeight,.flexibleWidth]
    }
}
