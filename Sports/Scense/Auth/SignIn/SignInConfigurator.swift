//
//  SignInConfigurator.swift
//  Sports
//
//  Created by ios Dev on 06/07/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct SignInInput { }

final class SignInConfigurator {
    
    // MARK: Configuration
    class func viewController(input: SignInInput) -> SignInViewController {
        let storyBoard = UIStoryboard.init(name: AuthStoryBoard, bundle: nil)
        guard let view = storyBoard.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController else { return SignInViewController() }
        let interactor = SignInInteractor()
        let router = SignInRouter(viewController: view)
        let presenter = SignInPresenter(view: view,
                                                          interactor: interactor,
                                                          router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
// MARK: - Protocols
// Controller --> Presenter
protocol SignInPresenterProtocol: AnyObject {
    func viewDidLoad()
    func signIn(with parameters: SignInRequest)
    func pushToSignup()
}

// Presenter --> Controller
protocol SignInControllerProtocol: AnyObject {
    func showFailureAlert(with error: String)
    func showLoadingIndicator()
    func showFailureIndicator()
}

// Presenter --> Interactor
protocol SignInPresenterInteractorProtocol: AnyObject {
    func signup(with parameters: SignInRequest)
}

// Interactor --> Presenter
protocol SignInInteractorOutput: AnyObject {
    func succeedSignIn(signInEntity: SignInEntity)
    func didFailedSignIn(error: Error)
    func showLoading()
    func dismissLoading()
}
// Presenter --> Router
protocol SignInRouterProtocol: AnyObject {
    func popViewController()
    func showSignupViewController()
}
