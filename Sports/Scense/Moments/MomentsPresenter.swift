//
//  MomentsPresenter.swift
//  Sports
//
//  Created by ios Dev on 27/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class MomentsPresenter: NSObject {
    // MARK: - Properties
    private var view: MomentsControllerProtocol?
    private var interactor: MomentsPresenterInteractorProtocol?
    private var router: MomentsRouterProtocol?
    
    private var followingMoments: [MomentsEntity] = []
    private var highlightsMoments: [MomentsEntity] = []

    internal var numberOfSections: Int { return MomentsSections.allCases.count }
    
    // MARK: - Init
    init(view: MomentsControllerProtocol?,
         interactor: MomentsPresenterInteractorProtocol?,
         router: MomentsRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// MARK: Conform to MomentsPresenterProtocol
extension MomentsPresenter: MomentsPresenterProtocol {
    
    func viewDidLoad() {
        interactor?.fetchFollowingMoments()
        interactor?.fetchHighlightMoments()
    }
    
    func numberOfRowsInSection(in section: MomentsSections) -> Int {
        switch section {
        case .following: return 1
        case .highlight: return 1
        }
    }
    
    func heightForRowInSection(in section: MomentsSections) -> CGFloat? {
        switch section {
        case .following: return 180
        case .highlight: return 800
        }
    }
    
    func configureHighlightsCell(for cell: HighlightMomentTableViewCell, delegate: MomentsCollectionCellViewControllerProtocol?) {
        let cellData = highlightsMoments
        cell.delegate = delegate
        cell.configureCell(with: cellData)
    }
    
    func configureFollowingCell(for cell: FollowingMomentTableViewCell, delegate: MomentsCollectionCellViewControllerProtocol?) {
        let cellData = followingMoments
        cell.delegate = delegate
        cell.configureCell(with: cellData)
    }
    
    func viewForHeaderInSection(in section: MomentsSections, for sectionView: HighlightHeaderTableViewCell) {
        switch section {
        case .following: sectionView.configureCell(title: "Following", isSeeAllEnabled: false)
        case .highlight: sectionView.configureCell(title: "Highlights", isSeeAllEnabled: false)
        }
    }
    
    func heightForHeaderInSection(in section: MomentsSections) -> CGFloat? {
        switch section {
        case .following: return 40.0
        case .highlight: return 40.0
        }
    }
    
    func didTappedMoment(with moment: MomentsEntity, allMoments: [MomentsEntity]) {
        router?.showFullMoment(story: moment, allStories: allMoments)
    }
}

// MARK: Conform to MomentsInteractorOutput
extension MomentsPresenter: MomentsInteractorOutput {
    
    func succeedReceivedFollowing(moments: [MomentsEntity]) {
        self.followingMoments = moments
        moments.isEmpty ? (view?.setEmptyState()) : (view?.loadTableView())
    }
    
    func succeedReceivedHighlights(moments: [MomentsEntity]) {
        self.highlightsMoments = moments
        moments.isEmpty ? (view?.setEmptyState()) : (view?.loadTableView())
    }
    
    func didFailedLoading(error: Error) {
        view?.showFailureAlert(with: error.localizedDescription)
    }
    
    func showLoading() {
        view?.showLoadingIndicator()
    }
    
    func dismissLoading() {
        view?.showFailureIndicator()
    }
}
