//
//  MatchOverviewConfigurator.swift
//  Sports
//
//  Created by ios Dev on 24/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct MatchOverviewInput { 
    let match: Match
}

final class MatchOverviewConfigurator {
    
    // MARK: Configuration
    class func viewController(input: MatchOverviewInput) -> MatchOverviewViewController {
        let view = MatchOverviewViewController()
        let interactor = MatchOverviewInteractor()
        let router = MatchOverviewRouter(viewController: view)
        let presenter = MatchOverviewPresenter(view: view,
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
protocol MatchOverviewPresenterProtocol: AnyObject {
    func viewDidLoad()
}

// Presenter --> Controller
protocol MatchOverviewControllerProtocol: AnyObject {
}

// Presenter --> Interactor
protocol MatchOverviewPresenterInteractorProtocol: AnyObject {
}

// Interactor --> Presenter
protocol MatchOverviewInteractorOutput: AnyObject {
}
// Presenter --> Router
protocol MatchOverviewRouterProtocol: AnyObject {
    func popViewController()
}
