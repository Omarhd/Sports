//
//  HomeConfigurator.swift
//  Sports
//
//  Created by ios Dev on 09/05/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Combine

struct MatchesInput { }

final class MatchesConfigurator {
    
    // MARK: Configuration
    class func viewController(input: MatchesInput) -> MatchesViewController {
        let storyBoard = UIStoryboard.init(name: MatchesStoryboard, bundle: nil)
        guard let view = storyBoard.instantiateViewController(withIdentifier: "MatchesViewController") as? MatchesViewController else { return MatchesViewController() }
        let interactor = MatchesInteractor()
        let router = MatchesRouter(viewController: view)
        let presenter = MatchesPresenter(view: view,
                                         interactor: interactor,
                                         router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}

// MARK: - Protocols
// Controller --> Presenter
protocol MatchesPresenterProtocol: AnyObject {
    func viewDidLoad()
    func setToday(for indexPath: Int)
    func configureFilterCell(with cell: DateFilterCollectionViewCell, for index: Int)
    func didSelectDate(for index: Int)
    func configureTournamentHeaderCell(with cell: TournamentHeaderTableViewCell, for section: Int)
    func configureCell(with cell: MatchTableViewCell, for indexPath: IndexPath)
    func didSelectMatch(for indexPath: IndexPath)
    func numberOfRowsInSection(for section: Int) -> Int
    func setSectionCollapse(isCollapsed: Bool, for section: Int)
    func fetchMatches(with matchType: MatchType)
    
    var selectedDateIndex: Int { get }
    var numberOfDateFilter: Int { get }
    var numberOfSections: Int { get }
    var heightForSectionHeader: CGFloat { get }
    var isSectionCollapsed: [Bool] { get }
    var numberOfMatches: [MatchList] { get }
    
    // MARK: - User Functionality
    func userDidPressed()
}

// Presenter --> Controller
protocol MatchesControllerProtocol: AnyObject {
    func setEmptyState()
    func showFailureAlert(with error: String)
    func loadTableView()
    func showLoadingIndicator()
    func showFailureIndicator()
    func highlightSelectedDate(for indexPath: IndexPath)
    func isToday()
    func itsNotToday()
}

// Presenter --> Interactor
protocol MatchesPresenterInteractorProtocol: AnyObject {
    func fetchDates()
    func fetchMatches(parameters: MatchesRequest)
    func fetchLiveMatches(parameters: LiveMatchesRequest)
}

// Interactor --> Presenter
protocol MatchesInteractorOutput: AnyObject {
    func didFetchDates(_ dates: [DateModel])
    func succeedReceivedMatches(matchesData: MatchesEntity)
    func didFailedLoadingMatches(error: Error)
    func showLoading()
    func dismissLoading()
}

// Presenter --> Router
protocol MatchesRouterProtocol: AnyObject {
    func popViewController()
    func navigateToDetails(match: Match)
    func navigateToProfile()
    func navigateToLogin()
}

// Filter Cell --> Protocol
protocol DateFilterCellProtocol: AnyObject {
    func configureFilter(date: DateModel)
}

// MatchCell --> Protocol
protocol MatchCellProtocol: AnyObject {
    func configureMatchCellUI(match: Match?)
    func configureLiveMatchCellUI(matchStatus: MatchStatus?, match: Match?)
}

// TournamentHeaderCell --> Protocol
protocol TournamentHeaderCellProtocol: AnyObject {
    func configureTournamentCellUI(title: String?, sectionIndex: Int, matchesCount: String, isCollapsed: Bool)
}
