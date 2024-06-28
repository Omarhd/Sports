//
//  MatchStandingRouter.swift
//  Sports
//
//  Created by ios Dev on 24/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MatchStandingRouter {
    weak var viewController: MatchStandingViewController?

    // MARK: - Init
    init(viewController: MatchStandingViewController) {
        self.viewController = viewController
    }
}
// MARK: Conforming to MatchStandingRouterProtocol
extension MatchStandingRouter: MatchStandingRouterProtocol {
    func popViewController() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
