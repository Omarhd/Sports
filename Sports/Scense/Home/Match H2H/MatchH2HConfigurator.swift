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
}

// Presenter --> Controller
protocol MatchH2HControllerProtocol: AnyObject {
}

// Presenter --> Interactor
protocol MatchH2HPresenterInteractorProtocol: AnyObject {
}

// Interactor --> Presenter
protocol MatchH2HInteractorOutput: AnyObject {
}
// Presenter --> Router
protocol MatchH2HRouterProtocol: AnyObject {
    func popViewController()
}
