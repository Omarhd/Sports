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
    
    private var selectedDateIndex: Int?
    private var collapsedSections: [Bool] = []

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
        view?.setInitialDateFilter(for: IndexPath(item: dates.count / 2, section: 0))
        let matchesParameters = MatchesRequest(pageNumber: 1, dated: Date().toFormattedString(),
                                               matchStatus: "scheduled",
                                               groupBy: "tournament")
        interactor?.fetchHotMatches(parameters: matchesParameters)
        collapsedSections = Array(repeating: false, count: numberOfSections)
    }
    
    func configureFilterCell(with cell: DateFilterCollectionViewCell, for index: Int) {
        let filterCellData = dates[index]
        cell.configureFilter(date: filterCellData)
    }
    
    func didSelectDate(for index: Int) {
        selectedDateIndex = index
        let date = dates[index].date
        let isTodayOrFuture = Calendar.current.isDate(date, inSameDayAs: Date()) || date > Date()
        let matchStatus = isTodayOrFuture ? "scheduled" : "finished"
        let matchesParameters = MatchesRequest(pageNumber: 1,
                                                   dated: date.toFormattedString(),
                                                   matchStatus: matchStatus)
        
        interactor?.fetchHotMatches(parameters: matchesParameters)
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
        cell.configureTournamentCellUI(title: headerTitle, sectionIndex: section)
    }
    
    func configureCell(with cell: MatchTableViewCell, for indexPath: IndexPath) {
        let cellData = tournaments[indexPath.section].match?[indexPath.row]
        cell.configureCellUI(match: cellData)
    }
    
    func didSelectMatch(for indexPath: IndexPath) {
        guard let match = tournaments[indexPath.section].match?[indexPath.row] else { return }
        router?.navigateToDetails(match: match)
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
        print(error.localizedDescription)
        view?.showFailureAlert(with: error.localizedDescription)
    }
}
