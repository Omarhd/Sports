//
//  MatchStatsRouter.swift
//  Sports
//
//  Created by ios Dev on 24/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MatchStatsRouter {
    weak var viewController: MatchStatsViewController?

    // MARK: - Init
    init(viewController: MatchStatsViewController) {
        self.viewController = viewController
    }
}
// MARK: Conforming to MatchStatsRouterProtocol
extension MatchStatsRouter: MatchStatsRouterProtocol {
    func popViewController() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
