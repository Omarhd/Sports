//
//  MatchDetailsConfigurator.swift
//  Sports
//
//  Created by ios Dev on 19/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Combine

struct MatchDetailsInput {
    let match: Match
}

final class MatchDetailsConfigurator {
    
    // MARK: Configuration
    class func viewController(input: MatchDetailsInput) -> MatchDetailsViewController {
        let storyBoard = UIStoryboard.init(name: HomeStoryboard, bundle: nil)
        guard let view = storyBoard.instantiateViewController(withIdentifier: "MatchDetailsViewController") as? MatchDetailsViewController else { return MatchDetailsViewController() }
        let interactor = MatchDetailsInteractor()
        let router = MatchDetailsRouter(viewController: view)
        let presenter = MatchDetailsPresenter(view: view,
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
protocol MatchDetailsPresenterProtocol: AnyObject {
    func viewDidLoad()
    func configureTabsCell(with cell: TabCollectionViewCell, for index: Int)
    func didSelectTab(for index: Int)
    func updateCollection(with index: Int)

    var allTabs: [Tabs] { get }
    var selectedTabIndex: Int { get }
}

// Presenter --> Controller
protocol MatchDetailsControllerProtocol: AnyObject {
    func configureTeamsUI(with match: Match)
    func configurePageController(with match: Match)
    func highlightSelectedTab(for indexPath: Int)
}

// Presenter --> Interactor
protocol MatchDetailsPresenterInteractorProtocol: AnyObject {
    func fetchTabs()
}

// Interactor --> Presenter
protocol MatchDetailsInteractorOutput: AnyObject {
    func didFetchTabs(_ tabs: [Tabs])
}

// Presenter --> Router
protocol MatchDetailsRouterProtocol: AnyObject {
    func popViewController()
}

// Filter Cell --> Protocol
protocol TabCellProtocol: AnyObject {
    func configureTab(tab: String)
}

extension Notification.Name {
    static let selectedTabIndexChanged = Notification.Name("selectedTabIndexChanged")
}
