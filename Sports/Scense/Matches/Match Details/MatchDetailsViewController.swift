//
//  MatchDetailsViewController.swift
//  Sports
//
//  Created by ios Dev on 19/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MatchDetailsViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var homeTeamNameLabel: UILabel!
    @IBOutlet weak var awayTeamNameLabel: UILabel!
    @IBOutlet weak var homeTeamImage: UIImageView!
    @IBOutlet weak var awayTeamImage: UIImageView!
    @IBOutlet weak var matchTimeLabel: UILabel!

    @IBOutlet weak var liveImageContentView: UIView!
    @IBOutlet weak var liveMatchAnimationImage: UIImageView!
    @IBOutlet weak var liveMatchTimeLabel: UILabel!
    
    @IBOutlet weak private var collectionView: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: Properties
    var presenter: MatchDetailsPresenterProtocol?
    var countdownTimer: CountdownTimer?

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        collectionView.registerCell(cell: TabCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension MatchDetailsViewController: MatchDetailsControllerProtocol {
  
    func configureMatchStatusUI(matchStatus: MatchStatus?, match: Match?) {
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
    
    func configureTeamsUI(with match: Match) {
        homeTeamNameLabel.text = match.details?.homeTeamDetail?.name
        awayTeamNameLabel.text = match.details?.awayTeamDetail?.name
        
        let homeTeamLogoUrl = match.details?.homeTeamDetail?.logo
        loadImages(loadImage: homeTeamImage, from: homeTeamLogoUrl)
        
        let awayTeamLogoUrl = match.details?.awayTeamDetail?.logo
        loadImages(loadImage: awayTeamImage, from: awayTeamLogoUrl)
    }
    
    func configurePageController(with match: Match) {
        let matchDetailsPageViewController = DetailsPagesConfigurator.viewController(input: .init(match: match,
                                                                                                  pageControllerDelegate: self))

        addChild(matchDetailsPageViewController)
        containerView.addSubview(matchDetailsPageViewController.view)
        
        matchDetailsPageViewController.didMove(toParent: self)
    }
    
    func highlightSelectedTab(for indexPath: Int) {
        collectionView.reloadData()
    }
    
}

extension MatchDetailsViewController: PageControllerViewDelegate {
    
    func updateCollectionIndex(with index: Int) {
        presenter?.updateCollection(with: index)
    }
}
