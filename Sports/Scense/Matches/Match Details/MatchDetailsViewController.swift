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
    @IBOutlet weak private var collectionView: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: Properties
    var presenter: MatchDetailsPresenterProtocol?

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
  
    func configureTeamsUI(with match: Match) {
        homeTeamNameLabel.text = match.details?.homeTeamDetail?.name
        awayTeamNameLabel.text = match.details?.awayTeamDetail?.name
        
        let homeTeamLogoUrl = URL(string: match.details?.homeTeamDetail?.logo ?? "")
        homeTeamImage.setImageWithSkeleton(with: homeTeamLogoUrl)
        
        let awayTeamLogoUrl = URL(string: match.details?.awayTeamDetail?.logo ?? "")
        awayTeamImage.setImageWithSkeleton(with: awayTeamLogoUrl)
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
