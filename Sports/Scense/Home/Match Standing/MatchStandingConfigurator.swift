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
}

// Presenter --> Controller
protocol MatchStandingControllerProtocol: AnyObject {
}

// Presenter --> Interactor
protocol MatchStandingPresenterInteractorProtocol: AnyObject {
}

// Interactor --> Presenter
protocol MatchStandingInteractorOutput: AnyObject {
}
// Presenter --> Router
protocol MatchStandingRouterProtocol: AnyObject {
    func popViewController()
}
