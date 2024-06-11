//
//  SocialMediaConfigurator.swift
//  Sports
//
//  Created by ios Dev on 24/05/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct SocialMediaInput { }

final class SocialMediaConfigurator {
    
    // MARK: Configuration
    class func viewController(input: SocialMediaInput) -> SocialMediaViewController {
        let view = SocialMediaViewController()
        let interactor = SocialMediaInteractor()
        let router = SocialMediaRouter(viewController: view)
        let presenter = SocialMediaPresenter(view: view,
                                                          interactor: interactor,
                                                          router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
// MARK: - Protocols
// Controller --> Presenter
protocol SocialMediaPresenterProtocol: AnyObject {
    func viewDidLoad()
}

// Presenter --> Controller
protocol SocialMediaControllerProtocol: AnyObject {
}

// Presenter --> Interactor
protocol SocialMediaPresenterInteractorProtocol: AnyObject {
}

// Interactor --> Presenter
protocol SocialMediaInteractorOutput: AnyObject {
}
// Presenter --> Router
protocol SocialMediaRouterProtocol: AnyObject {
    func popViewController()
}
