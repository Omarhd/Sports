//
//  SettingsConfigurator.swift
//  Sports
//
//  Created by ios Dev on 24/05/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct SettingsInput { }

final class SettingsConfigurator {
    
    // MARK: Configuration
    class func viewController(input: SettingsInput) -> SettingsViewController {
        let storyBoard = UIStoryboard.init(name: SettingsStoryboard, bundle: nil)
        guard let view = storyBoard.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController else { return SettingsViewController() }
        let interactor = SettingsInteractor()
        let router = SettingsRouter(viewController: view)
        let presenter = SettingsPresenter(view: view,
                                                          interactor: interactor,
                                                          router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
// MARK: - Protocols
// Controller --> Presenter
protocol SettingsPresenterProtocol: AnyObject {
    func viewDidLoad()
}

// Presenter --> Controller
protocol SettingsControllerProtocol: AnyObject {
}

// Presenter --> Interactor
protocol SettingsPresenterInteractorProtocol: AnyObject {
}

// Interactor --> Presenter
protocol SettingsInteractorOutput: AnyObject {
}
// Presenter --> Router
protocol SettingsRouterProtocol: AnyObject {
    func popViewController()
}
