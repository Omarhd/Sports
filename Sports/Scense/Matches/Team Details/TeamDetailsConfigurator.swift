//
//  TeamDetailsConfigurator.swift
//  Sports
//
//  Created by ios Dev on 27/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct TeamDetailsInput { }

final class TeamDetailsConfigurator {
    
    // MARK: Configuration
    class func viewController(input: TeamDetailsInput) -> TeamDetailsViewController {
        let view = TeamDetailsViewController()
        let interactor = TeamDetailsInteractor()
        let router = TeamDetailsRouter(viewController: view)
        let presenter = TeamDetailsPresenter(view: view,
                                                          interactor: interactor,
                                                          router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
// MARK: - Protocols
// Controller --> Presenter
protocol TeamDetailsPresenterProtocol: AnyObject {
    func viewDidLoad()
}

// Presenter --> Controller
protocol TeamDetailsControllerProtocol: AnyObject {
}

// Presenter --> Interactor
protocol TeamDetailsPresenterInteractorProtocol: AnyObject {
}

// Interactor --> Presenter
protocol TeamDetailsInteractorOutput: AnyObject {
}
// Presenter --> Router
protocol TeamDetailsRouterProtocol: AnyObject {
    func popViewController()
}
