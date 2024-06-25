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
}

// Presenter --> Controller
protocol MatchOddsControllerProtocol: AnyObject {
}

// Presenter --> Interactor
protocol MatchOddsPresenterInteractorProtocol: AnyObject {
}

// Interactor --> Presenter
protocol MatchOddsInteractorOutput: AnyObject {
}
// Presenter --> Router
protocol MatchOddsRouterProtocol: AnyObject {
    func popViewController()
}
