//
//  MatchOddsConfigurator.swift
//  Sports
//
//  Created by ios Dev on 24/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct MatchOddsInput {
    let match: Match
}

final class MatchOddsConfigurator {
    
    // MARK: Configuration
    class func viewController(input: MatchOddsInput) -> MatchOddsViewController {
        let view = MatchOddsViewController()
        let interactor = MatchOddsInteractor()
        let router = MatchOddsRouter(viewController: view)
        let presenter = MatchOddsPresenter(view: view,
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
protocol MatchOddsPresenterProtocol: AnyObject {
    func viewDidLoad()
    func configureOddsSelectionCell(for cell: MatchOddsSelectionTableViewCell, for index: IndexPath, delegate: MatchOddsSelectionTableViewCellProtocol)
    func configureOddsMatchCell(for cell: MatchOddsTableViewCell, for index: IndexPath)
    func numberOfRowsInSection(in section: OddsSection) -> Int
    func heightForRowInSection(in section: OddsSection) -> CGFloat
    
    var selectedOption: OddsSelection { get set }
    var numberOfSections: Int { get }
}

// Presenter --> Controller
protocol MatchOddsControllerProtocol: AnyObject {
    func setEmptyState()
    func showFailureAlert(with error: String)
    func loadTableView()
    func showLoadingIndicator()
    func showFailureIndicator()
}

// Presenter --> Interactor
protocol MatchOddsPresenterInteractorProtocol: AnyObject {
    func fetchOddsData(with parameters: OddsRequest)
    func fetchOddsSelectionOptions()
}

// Interactor --> Presenter
protocol MatchOddsInteractorOutput: AnyObject {
    func didFetchedOddsSelectionOptions(options: [OddsSelection])
    func succeedReceivedOddsData(odds: MatchOddsEntity)
    func didFailedLoadingOddsData(error: Error)
    func showLoading()
    func dismissLoading()
}
// Presenter --> Router
protocol MatchOddsRouterProtocol: AnyObject {
    func popViewController()
}

protocol MatchOddsSelectionProtocol: AnyObject {
    func configureCell(with options: [OddsSelection])
}

protocol MatchOddsCellProtocol: AnyObject {
    func configureCell(with odds: [DatumUnion]?)
}

protocol MatchOddsSelectionTableViewCellProtocol: AnyObject {
    func didSelectOption(with index: OddsSelection)
}
