//
//  HomeConfigurator.swift
//  Sports
//
//  Created by ios Dev on 09/05/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Combine

struct HomeInput { }

final class HomeConfigurator {
    
    // MARK: Configuration
    class func viewController(input: HomeInput) -> HomeViewController {
        let storyBoard = UIStoryboard.init(name: HomeStoryboard, bundle: nil)
        guard let view = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else { return HomeViewController() }
        let interactor = HomeInteractor()
        let router = HomeRouter(viewController: view)
        let presenter = HomePresenter(view: view,
                                      interactor: interactor,
                                      router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}

// MARK: - Protocols
// Controller --> Presenter
protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
    func configureFilterCell(with cell: DateFilterCollectionViewCell, for index: Int)
    func didSelectDate(for index: Int)
    func configureTournamentHeaderCell(with cell: TournamentHeaderTableViewCell, for section: Int)
    func configureCell(with cell: MatchTableViewCell, for indexPath: IndexPath)
    func didSelectMatch(for indexPath: IndexPath)
    func numberOfRowsInSection(for section: Int) -> Int
    func setSectionCollapse(isCollapsed: Bool, for section: Int)
    
    var numberOfDateFilter: Int { get }
    var numberOfSections: Int { get }
    var heightForSectionHeader: CGFloat { get }
    var isSectionCollapsed: [Bool] { get }
    var numberOfMatches: [MatchList] { get }
}

// Presenter --> Controller
protocol HomeControllerProtocol: AnyObject {
    func setEmptyState()
    func showFailureAlert(with error: String)
    func loadTableView()
    func showLoadingIndicator()
    func showFailureIndicator()
    func setInitialDateFilter(for indexPath: IndexPath)
}

// Presenter --> Interactor
protocol HomePresenterInteractorProtocol: AnyObject {
    func fetchDates()
    func fetchHotMatches(parameters: MatchesRequest)
}

// Interactor --> Presenter
protocol HomeInteractorOutput: AnyObject {
    func didFetchDates(_ dates: [DateModel])
    func succeedReceivedMatches(matchesData: HomeEntity)
    func didFailedLoadingMatches(error: Error)
    func showLoading()
    func dismissLoading()
}

// Presenter --> Router
protocol HomeRouterProtocol: AnyObject {
    func popViewController()
    func navigateToDetails(match: Match)
}

// Filter Cell --> Protocol
protocol DateFilterCellProtocol: AnyObject {
    func configureFilter(date: DateModel)
}

// MatchCell --> Protocol
protocol MatchCellProtocol: AnyObject {
    func configureCellUI(match: Match?)
}

// TournamentHeaderCell --> Protocol
protocol TournamentHeaderCellProtocol: AnyObject {
    func configureTournamentCellUI(title: String?, sectionIndex: Int)
}
