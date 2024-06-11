//
//  SettingsRouter.swift
//  Sports
//
//  Created by ios Dev on 24/05/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class SettingsRouter {
    weak var viewController: SettingsViewController?

    // MARK: - Init
    init(viewController: SettingsViewController) {
        self.viewController = viewController
    }
}
// MARK: Conforming to SettingsRouterProtocol
extension SettingsRouter: SettingsRouterProtocol {
    func popViewController() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
