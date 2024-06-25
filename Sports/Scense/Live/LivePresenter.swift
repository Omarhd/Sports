//
//  LivePresenter.swift
//  Sports
//
//  Created by ios Dev on 20/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class LivePresenter: NSObject {
    
    // MARK: - Properties
    private var view: LiveControllerProtocol?
    private var interactor: LivePresenterInteractorProtocol?
    private var router: LiveRouterProtocol?
    
    private var collapsedSections: [Bool] = []
    var liveMatches: [MatchList] = []
    
    var numberOfSections: Int { return liveMatches.count }
    var numberOfMatches: [MatchList] { return liveMatches }
    var heightForSectionHeader: CGFloat = 50.0
    
    var isSectionCollapsed: [Bool] {
        return collapsedSections
    }

    // MARK: - Init
    init(view: LiveControllerProtocol?,
         interactor: LivePresenterInteractorProtocol?,
         router: LiveRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// MARK: Conform to LivePresenterProtocol
extension LivePresenter: LivePresenterProtocol {
    
    func viewDidLoad() {
        let matchesParameters = LiveMatchesRequest(pageNumber: 1)
        interactor?.fetchLiveMatches(parameters: matchesParameters)
        collapsedSections = Array(repeating: false, count: numberOfSections)
    }
    
    func setSectionCollapse(isCollapsed: Bool, for section: Int) {
        if section < collapsedSections.count {
            collapsedSections[section] = isCollapsed
        }
    }
    
    func numberOfRowsInSection(for section: Int) -> Int {
        return collapsedSections[section] ? 0 : (liveMatches[section].match?.count ?? 0)
    }
    
    func configureTournamentHeaderCell(with cell: TournamentHeaderTableViewCell, for section: Int) {
        let headerTitle = liveMatches[section].tournamentName
        let isCollapsed = isSectionCollapsed[section]
        let matchesCount = isCollapsed ? (liveMatches[section].match?.count.description ?? "0") : ("0")
        cell.configureTournamentCellUI(title: headerTitle, sectionIndex: section, matchesCount: matchesCount, isCollapsed: isCollapsed)
    }
    
    func configureCell(with cell: MatchTableViewCell, for indexPath: IndexPath) {
        let cellData = liveMatches[indexPath.section].match?[indexPath.row]
        cell.configureMatchCellUI(match: cellData)
        cell.configureLiveMatchCellUI(matchStatus: cellData?.details?.matchDetails?.statusID ?? .abnormal, match: cellData)
    }
    
    func didSelectMatch(for indexPath: IndexPath) {
        guard let match = liveMatches[indexPath.section].match?[indexPath.row] else { return }
        router?.navigateToDetails(match: match)
    }
}

// MARK: Conform to LiveInteractorOutput
extension LivePresenter: LiveInteractorOutput {
    
    func showLoading() {
        view?.showLoadingIndicator()
    }
    
    func dismissLoading() {
        view?.showFailureIndicator()
    }
    
    func succeedReceivedMatches(matchesData: HomeEntity) {
        liveMatches = matchesData.matchList ?? []
        collapsedSections = Array(repeating: false, count: liveMatches.count)
        liveMatches.isEmpty ? view?.setEmptyState() : view?.loadTableView()
    }
    
    func didFailedLoadingMatches(error: Error) {
        view?.showFailureAlert(with: error.localizedDescription)
    }
    
}
