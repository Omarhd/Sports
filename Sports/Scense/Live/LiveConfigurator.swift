//
//  LiveConfigurator.swift
//  Sports
//
//  Created by ios Dev on 20/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct LiveInput { }

final class LiveConfigurator {
    
    // MARK: Configuration
    class func viewController(input: LiveInput) -> LiveViewController {
        let view = LiveViewController()
        let interactor = LiveInteractor()
        let router = LiveRouter(viewController: view)
        let presenter = LivePresenter(view: view,
                                      interactor: interactor,
                                      router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
// MARK: - Protocols
// Controller --> Presenter
protocol LivePresenterProtocol: AnyObject {
    func viewDidLoad()
    func configureTournamentHeaderCell(with cell: TournamentHeaderTableViewCell, for section: Int)
    func configureCell(with cell: MatchTableViewCell, for indexPath: IndexPath)
    func didSelectMatch(for indexPath: IndexPath)
    func numberOfRowsInSection(for section: Int) -> Int
    func setSectionCollapse(isCollapsed: Bool, for section: Int)
    
    var numberOfSections: Int { get }
    var heightForSectionHeader: CGFloat { get }
    var isSectionCollapsed: [Bool] { get }
    var numberOfMatches: [MatchList] { get }
}

// Presenter --> Controller
protocol LiveControllerProtocol: AnyObject {
    func setEmptyState()
    func showFailureAlert(with error: String)
    func loadTableView()
    func showLoadingIndicator()
    func showFailureIndicator()
}

// Presenter --> Interactor
protocol LivePresenterInteractorProtocol: AnyObject {
    func fetchLiveMatches(parameters: LiveMatchesRequest)
}

// Interactor --> Presenter
protocol LiveInteractorOutput: AnyObject {
    func succeedReceivedMatches(matchesData: HomeEntity)
    func didFailedLoadingMatches(error: Error)
    func showLoading()
    func dismissLoading()
}
// Presenter --> Router
protocol LiveRouterProtocol: AnyObject {
    func navigateToDetails(match: Match)
    func popViewController()
}
