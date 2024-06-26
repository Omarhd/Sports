//
//  MatchStandingConfigurator.swift
//  Sports
//
//  Created by ios Dev on 24/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct MatchStandingInput { 
    let match: Match
}

final class MatchStandingConfigurator {
    
    // MARK: Configuration
    class func viewController(input: MatchStandingInput) -> MatchStandingViewController {
        let view = MatchStandingViewController()
        let interactor = MatchStandingInteractor()
        let router = MatchStandingRouter(viewController: view)
        let presenter = MatchStandingPresenter(view: view,
                                               interactor: interactor,
                                               router: router,
                                               match: input.match)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
// MARK: - Protocols
// Controller --> Presenter
protocol MatchStandingPresenterProtocol: AnyObject {
    func viewDidLoad()
    func configureSeasonSelectionCell(for cell: SeasonSelectionTableViewCell, for index: IndexPath, delegate: SeasonSelectionTableViewCellProtocol)
    func configureSeasonTeamCell(for cell: SeasonTeamTableViewCell, for index: IndexPath, with format: SeasonSelection)
    func numberOfRowsInSection(in section: SeasonSection) -> Int
    func heightForRowInSection(in section: SeasonSection) -> CGFloat
    func viewForHeaderInSection(in section: SeasonSection, with header: SeasonStandingHeaderTableViewCell, and format: SeasonSelection)
    func heighForHeaderInSection(in section: SeasonSection) -> CGFloat
    
    var selectedOption: SeasonSelection { get set }
    var numberOfSections: Int { get }
}

// Presenter --> Controller
protocol MatchStandingControllerProtocol: AnyObject {
    func setEmptyState()
    func showFailureAlert(with error: String)
    func loadTableView()
    func showLoadingIndicator()
    func showFailureIndicator()
}

// Presenter --> Interactor
protocol MatchStandingPresenterInteractorProtocol: AnyObject {
    func fetchSeasonStandingData(with parameters: StandingSeasonRequest)
    func fetchSeasonSelectionOptions()
}

// Interactor --> Presenter
protocol MatchStandingInteractorOutput: AnyObject {
    func didFetchedSeasonSelectionOptions(options: [SeasonSelection])
    func succeedReceivedStandingSeasonData(season: StandingSeasonEntity)
    func didFailedLoadingSeasonData(error: Error)
    func showLoading()
    func dismissLoading()
}

// Presenter --> Router
protocol MatchStandingRouterProtocol: AnyObject {
    func popViewController()
}

protocol SeasonSelectionProtocol: AnyObject {
    func configureCell(with options: [SeasonSelection])
}

protocol SeasonTeamCellProtocol: AnyObject {
    func configureCell(with team: StandingsData?)
}

protocol SeasonSelectionTableViewCellProtocol: AnyObject {
    func didSelectOption(with index: SeasonSelection)
}
