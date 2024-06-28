//
//  MatchStatsConfigurator.swift
//  Sports
//
//  Created by ios Dev on 24/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct MatchStatsInput { 
    let match: Match
}

final class MatchStatsConfigurator {
    
    // MARK: Configuration
    class func viewController(input: MatchStatsInput) -> MatchStatsViewController {
        let view = MatchStatsViewController()
        let interactor = MatchStatsInteractor()
        let router = MatchStatsRouter(viewController: view)
        let presenter = MatchStatsPresenter(view: view,
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
protocol MatchStatsPresenterProtocol: AnyObject {
    func viewDidLoad()
    func configureStatCell(for cell: StatTableViewCell, for index: Int)
    
    var numberOfRowsInSection: Int { get }
    var numberOfSections: Int { get }
}

// Presenter --> Controller
protocol MatchStatsControllerProtocol: AnyObject {
    func reloadTableView()
    func setEmptyView()
}

// Presenter --> Interactor
protocol MatchStatsPresenterInteractorProtocol: AnyObject {
}

// Interactor --> Presenter
protocol MatchStatsInteractorOutput: AnyObject {
}
// Presenter --> Router
protocol MatchStatsRouterProtocol: AnyObject {
    func popViewController()
}

protocol StatCellProtocol: AnyObject {
    func configureCell(with stats: [Double])
}
