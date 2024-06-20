//
//  MatchDetailsConfigurator.swift
//  Sports
//
//  Created by ios Dev on 19/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct MatchDetailsInput {
    var match: Match
}

final class MatchDetailsConfigurator {
    
    // MARK: Configuration
    class func viewController(input: MatchDetailsInput) -> MatchDetailsViewController {
        let view = MatchDetailsViewController()
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
}

// Presenter --> Controller
protocol MatchDetailsControllerProtocol: AnyObject {
}

// Presenter --> Interactor
protocol MatchDetailsPresenterInteractorProtocol: AnyObject {
}

// Interactor --> Presenter
protocol MatchDetailsInteractorOutput: AnyObject {
}
// Presenter --> Router
protocol MatchDetailsRouterProtocol: AnyObject {
    func popViewController()
}
