//
//  MatchH2HConfigurator.swift
//  Sports
//
//  Created by ios Dev on 24/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct MatchH2HInput { 
    let match: Match
}

final class MatchH2HConfigurator {
    
    // MARK: Configuration
    class func viewController(input: MatchH2HInput) -> MatchH2HViewController {
        let view = MatchH2HViewController()
        let interactor = MatchH2HInteractor()
        let router = MatchH2HRouter(viewController: view)
        let presenter = MatchH2HPresenter(view: view,
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
protocol MatchH2HPresenterProtocol: AnyObject {
    func viewDidLoad()
    func configureH2HSelectionCell(for cell: MatchH2HSelectionTableViewCell, for index: IndexPath, delegate: MatchH2HSelectionTableViewCellProtocol)
    func configureH2HVersesMatchCell(for cell: MatchH2HTableViewCell, for index: IndexPath)
    func numberOfRowsInSection(in section: H2HSection) -> Int
    func heightForRowInSection(in section: H2HSection) -> CGFloat

    var selectedOption: TeamSelection { get set }
    var numberOfSections: Int { get }
}

// Presenter --> Controller
protocol MatchH2HControllerProtocol: AnyObject {
    func setEmptyState()
    func showFailureAlert(with error: String)
    func loadTableView()
    func showLoadingIndicator()
    func showFailureIndicator()
}

// Presenter --> Interactor
protocol MatchH2HPresenterInteractorProtocol: AnyObject {
    func fetchH2HData(with parameters: HeadToHeadRequest)
    func fetchH2HSelectionOptions()
}

// Interactor --> Presenter
protocol MatchH2HInteractorOutput: AnyObject {
    func didFetchedH2HSelectionOptions(options: [TeamSelection])
    func succeedReceivedH2HData(h2hData: MatchH2HEntity)
    func didFailedLoadingH2HData(error: Error)
    func showLoading()
    func dismissLoading()
}
// Presenter --> Router
protocol MatchH2HRouterProtocol: AnyObject {
    func popViewController()
}

protocol MatchH2HSelectionProtocol: AnyObject {
    func configureCell(with options: [TeamSelection])
}

protocol MatchH2HCellProtocol: AnyObject {
    func configureCell(with match: H2HMatch?)
}

protocol MatchH2HSelectionTableViewCellProtocol: AnyObject {
    func didSelectOption(with index: TeamSelection)
}
