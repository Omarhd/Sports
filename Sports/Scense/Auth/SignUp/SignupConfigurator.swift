//
//  SignupConfigurator.swift
//  Sports
//
//  Created by ios Dev on 04/07/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct SignupInput { }

final class SignupConfigurator {
    
    // MARK: Configuration
    class func viewController(input: SignupInput) -> SignupViewController {
        let storyBoard = UIStoryboard.init(name: AuthStoryBoard, bundle: nil)
        guard let view = storyBoard.instantiateViewController(withIdentifier: "SignupViewController") as? SignupViewController else { return SignupViewController() }
        let interactor = SignupInteractor()
        let router = SignupRouter(viewController: view)
        let presenter = SignupPresenter(view: view,
                                                          interactor: interactor,
                                                          router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
// MARK: - Protocols
// Controller --> Presenter
protocol SignupPresenterProtocol: AnyObject {
    func viewDidLoad()
    func signUP(with parameters: signupRequest)
}

// Presenter --> Controller
protocol SignupControllerProtocol: AnyObject {
    func showFailureAlert(with error: String)
    func showLoadingIndicator()
    func showFailureIndicator()
}

// Presenter --> Interactor
protocol SignupPresenterInteractorProtocol: AnyObject {
    func signup(with parameters: signupRequest)
}

// Interactor --> Presenter
protocol SignupInteractorOutput: AnyObject {
    func succeedSignup(signupEntity: SignupEntity)
    func didFailedSignup(error: Error)
    func showLoading()
    func dismissLoading()
}
// Presenter --> Router
protocol SignupRouterProtocol: AnyObject {
    func popViewController()
    func showVerificationPage(with token: String)
}
