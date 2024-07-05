//
//  ConfirmOTPConfigurator.swift
//  Sports
//
//  Created by ios Dev on 04/07/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct ConfirmOTPInput {
    let token: String
}

final class ConfirmOTPConfigurator {
    
    // MARK: Configuration
    class func viewController(input: ConfirmOTPInput) -> ConfirmOTPViewController {
        let storyBoard = UIStoryboard.init(name: AuthStoryBoard, bundle: nil)
        guard let view = storyBoard.instantiateViewController(withIdentifier: "ConfirmOTPViewController") as? ConfirmOTPViewController else { return ConfirmOTPViewController() }
        let interactor = ConfirmOTPInteractor()
        let router = ConfirmOTPRouter(viewController: view)
        let presenter = ConfirmOTPPresenter(view: view,
                                            interactor: interactor,
                                            router: router,
                                            token: input.token)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
// MARK: - Protocols
// Controller --> Presenter
protocol ConfirmOTPPresenterProtocol: AnyObject {
    func viewDidLoad()
}

// Presenter --> Controller
protocol ConfirmOTPControllerProtocol: AnyObject {
}

// Presenter --> Interactor
protocol ConfirmOTPPresenterInteractorProtocol: AnyObject {
}

// Interactor --> Presenter
protocol ConfirmOTPInteractorOutput: AnyObject {
}
// Presenter --> Router
protocol ConfirmOTPRouterProtocol: AnyObject {
    func popViewController()
}
