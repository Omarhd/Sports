//
//  HomePresenter.swift
//  Sports
//
//  Created by ios Dev on 09/05/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class HomePresenter: NSObject {
    // MARK: - Properties
    private var view: HomeControllerProtocol?
    private var interactor: HomePresenterInteractorProtocol?
    private var router: HomeRouterProtocol?
    
    private var matchType: MatchType = .dated
    
    private var collapsedSections: [Bool] = []
    var selectedDateIndex: Int = 6

    var dates: [DateModel] = []
    var tournaments: [MatchList] = []
    
    var numberOfDateFilter: Int { return dates.count }
    var numberOfSections: Int { return tournaments.count }
    var numberOfMatches: [MatchList] { return tournaments }
    var heightForSectionHeader: CGFloat = 50.0
    
    var isSectionCollapsed: [Bool] {
        return collapsedSections
    }
    
    // MARK: - Init
    init(view: HomeControllerProtocol?,
         interactor: HomePresenterInteractorProtocol?,
         router: HomeRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// MARK: Conform to HomePresenterProtocol
extension HomePresenter: HomePresenterProtocol {
    
    func viewDidLoad() {
        interactor?.fetchDates()
        view?.highlightSelectedDate(for: IndexPath(item: selectedDateIndex, section: 0))
        fetchMatches(with: .dated)
    }
    
    func setToday(for indexPath: Int) {
        view?.isToday()
        view?.highlightSelectedDate(for: IndexPath(row: indexPath, section: 0))
        selectedDateIndex = indexPath
        fetchMatches(with: .dated)
    }
    
    func configureFilterCell(with cell: DateFilterCollectionViewCell, for index: Int) {
        cell.isSelected = index == selectedDateIndex
        let filterCellData = dates[index]
        cell.configureFilter(date: filterCellData)
    }
    
    func didSelectDate(for index: Int) {
        view?.highlightSelectedDate(for: IndexPath(item: index, section: 0))
        selectedDateIndex = index
        let date = dates[index].date
        let isTodayOrFuture = Calendar.current.isDate(date, inSameDayAs: Date()) || date > Date()
        let matchStatus: FetchMatchStatus = isTodayOrFuture ? .scheduled : .finished
        let matchesParameters = MatchesRequest(pageNumber: 1,
                                                   dated: date.toFormattedString(),
                                                   matchStatus: matchStatus)
        
        interactor?.fetchMatches(parameters: matchesParameters)
        
        let isToday = Calendar.current.isDate(date, inSameDayAs: Date())
        isToday ? (view?.isToday()) : (view?.itsNotToday())
    }

    func setSectionCollapse(isCollapsed: Bool, for section: Int) {
        if section < collapsedSections.count {
            collapsedSections[section] = isCollapsed
        }
    }
    
    func numberOfRowsInSection(for section: Int) -> Int {
        return collapsedSections[section] ? 0 : (tournaments[section].match?.count ?? 0)
    }
    
    func configureTournamentHeaderCell(with cell: TournamentHeaderTableViewCell, for section: Int) {
        let headerTitle = tournaments[section].tournamentName
        let isCollapsed = isSectionCollapsed[section]
        let matchesCount = isCollapsed ? (tournaments[section].match?.count.description ?? "0") : ("0")
        cell.configureTournamentCellUI(title: headerTitle, sectionIndex: section, matchesCount: matchesCount, isCollapsed: isCollapsed)
    }
    
    func configureCell(with cell: MatchTableViewCell, for indexPath: IndexPath) {
        let cellData = tournaments[indexPath.section].match?[indexPath.row]
        cell.configureMatchCellUI(match: cellData)
        cell.configureLiveMatchCellUI(matchStatus: cellData?.details?.matchDetails?.statusID ?? .abnormal, match: cellData)
    }
    
    func didSelectMatch(for indexPath: IndexPath) {
        guard let match = tournaments[indexPath.section].match?[indexPath.row] else { return }
        router?.navigateToDetails(match: match)
    }
    
    func fetchMatches(with matchType: MatchType) {
        let liveMatchParameters: LiveMatchesRequest = .init(pageNumber: 1)
        let matchesParameters: MatchesRequest = .init(pageNumber: 1, dated: Date().toFormattedString(),
                                               matchStatus: .scheduled)
        switch matchType {
        case .dated:
            interactor?.fetchMatches(parameters: matchesParameters)
        case .live:
            interactor?.fetchLiveMatches(parameters: liveMatchParameters)
        }
        collapsedSections = Array(repeating: false, count: numberOfSections)
    }
    
}

// MARK: Conform to HomeInteractorOutput
extension HomePresenter: HomeInteractorOutput {
    
    func didFetchDates(_ dates: [DateModel]) {
        self.dates = dates
    }
    
    func showLoading() {
        view?.showLoadingIndicator()
    }
    
    func dismissLoading() {
        view?.showFailureIndicator()
    }
    
    func succeedReceivedMatches(matchesData: HomeEntity) {
        tournaments = matchesData.matchList ?? []
        collapsedSections = Array(repeating: false, count: tournaments.count)
        tournaments.isEmpty ? view?.setEmptyState() : view?.loadTableView()
    }
    
    func didFailedLoadingMatches(error: Error) {
        view?.showFailureAlert(with: error.localizedDescription)
    }
}
