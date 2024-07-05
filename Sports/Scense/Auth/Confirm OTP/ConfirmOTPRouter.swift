//
//  ConfirmOTPRouter.swift
//  Sports
//
//  Created by ios Dev on 04/07/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class ConfirmOTPRouter {
    weak var viewController: ConfirmOTPViewController?

    // MARK: - Init
    init(viewController: ConfirmOTPViewController) {
        self.viewController = viewController
    }
}
// MARK: Conforming to ConfirmOTPRouterProtocol
extension ConfirmOTPRouter: ConfirmOTPRouterProtocol {
    func popViewController() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
