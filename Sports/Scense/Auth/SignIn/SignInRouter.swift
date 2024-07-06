//
//  SignInRouter.swift
//  Sports
//
//  Created by ios Dev on 06/07/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class SignInRouter {
    weak var viewController: SignInViewController?

    // MARK: - Init
    init(viewController: SignInViewController) {
        self.viewController = viewController
    }
}
// MARK: Conforming to SignInRouterProtocol
extension SignInRouter: SignInRouterProtocol {
  
    func popViewController() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    
    func showSignupViewController() {
        let signupViewController = SignupConfigurator.viewController(input: .init())
        viewController?.navigationController?.pushViewController(signupViewController, animated: true)
    }
}
