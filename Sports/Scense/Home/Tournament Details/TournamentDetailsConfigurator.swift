//
//  TournamentDetailsConfigurator.swift
//  Sports
//
//  Created by ios Dev on 13/05/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct TournamentDetailsInput { 
    var tournament: Tournament
}

final class TournamentDetailsConfigurator {
    
    // MARK: Configuration
    class func viewController(input: TournamentDetailsInput) -> TournamentDetailsViewController {
        let view = TournamentDetailsViewController()
        let interactor = TournamentDetailsInteractor()
        let router = TournamentDetailsRouter(viewController: view)
        let presenter = TournamentDetailsPresenter(view: view,
                                                          interactor: interactor,
                                                   router: router,
                                                   tournament: input.tournament)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
// MARK: - Protocols
// Controller --> Presenter
protocol TournamentDetailsPresenterProtocol: AnyObject {
    func viewDidLoad()
}

// Presenter --> Controller
protocol TournamentDetailsControllerProtocol: AnyObject {
}

// Presenter --> Interactor
protocol TournamentDetailsPresenterInteractorProtocol: AnyObject {
}

// Interactor --> Presenter
protocol TournamentDetailsInteractorOutput: AnyObject {
}
// Presenter --> Router
protocol TournamentDetailsRouterProtocol: AnyObject {
    func popViewController()
}
