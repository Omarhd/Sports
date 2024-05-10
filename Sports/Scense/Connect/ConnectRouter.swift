//
//  ConnectRouter.swift
//  Sports
//
//  Created by ios Dev on 10/05/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class ConnectRouter {
    weak var viewController: ConnectViewController?

    // MARK: - Init
    init(viewController: ConnectViewController) {
        self.viewController = viewController
    }
}
// MARK: Conforming to ConnectRouterProtocol
extension ConnectRouter: ConnectRouterProtocol {
    func popViewController() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
