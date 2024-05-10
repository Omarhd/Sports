//
//  ConnectConfigurator.swift
//  Sports
//
//  Created by ios Dev on 10/05/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct ConnectInput { }

final class ConnectConfigurator {
    
    // MARK: Configuration
    class func viewController(input: ConnectInput) -> ConnectViewController {
        let view = ConnectViewController()
        let interactor = ConnectInteractor()
        let router = ConnectRouter(viewController: view)
        let presenter = ConnectPresenter(view: view,
                                                          interactor: interactor,
                                                          router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
// MARK: - Protocols
// Controller --> Presenter
protocol ConnectPresenterProtocol: AnyObject {
    func viewDidLoad()
}

// Presenter --> Controller
protocol ConnectControllerProtocol: AnyObject {
}

// Presenter --> Interactor
protocol ConnectPresenterInteractorProtocol: AnyObject {
}

// Interactor --> Presenter
protocol ConnectInteractorOutput: AnyObject {
}
// Presenter --> Router
protocol ConnectRouterProtocol: AnyObject {
    func popViewController()
}
