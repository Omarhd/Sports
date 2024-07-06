//
//  SignupRouter.swift
//  Sports
//
//  Created by ios Dev on 04/07/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class SignupRouter {
    weak var viewController: SignupViewController?

    // MARK: - Init
    init(viewController: SignupViewController) {
        self.viewController = viewController
    }
}
// MARK: Conforming to SignupRouterProtocol
extension SignupRouter: SignupRouterProtocol {
    
    func popViewController() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    
    func showVerificationPage(with token: String) {
        let confirmOTPViewController = ConfirmOTPConfigurator.viewController(input: .init(token: token))
        let backButton = UIBarButtonItem()
        backButton.title = ""
        confirmOTPViewController.isModalInPresentation = true
        viewController?.navigationItem.backBarButtonItem = backButton
        viewController?.navigationController?.pushViewController(confirmOTPViewController, animated: true)
    }
}
