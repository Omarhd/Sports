//
//  MomentsConfigurator.swift
//  Sports
//
//  Created by ios Dev on 27/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct MomentsInput { }

final class MomentsConfigurator {
    
    // MARK: Configuration
    class func viewController(input: MomentsInput) -> MomentsViewController {
        let view = MomentsViewController()
        let interactor = MomentsInteractor()
        let router = MomentsRouter(viewController: view)
        let presenter = MomentsPresenter(view: view,
                                                          interactor: interactor,
                                                          router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
// MARK: - Protocols
// Controller --> Presenter
protocol MomentsPresenterProtocol: AnyObject {
    func viewDidLoad()
}

// Presenter --> Controller
protocol MomentsControllerProtocol: AnyObject {
}

// Presenter --> Interactor
protocol MomentsPresenterInteractorProtocol: AnyObject {
}

// Interactor --> Presenter
protocol MomentsInteractorOutput: AnyObject {
}
// Presenter --> Router
protocol MomentsRouterProtocol: AnyObject {
    func popViewController()
}
