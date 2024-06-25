//
//  MatchOverviewRouter.swift
//  Sports
//
//  Created by ios Dev on 24/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MatchOverviewRouter {
    weak var viewController: MatchOverviewViewController?

    // MARK: - Init
    init(viewController: MatchOverviewViewController) {
        self.viewController = viewController
    }
}
// MARK: Conforming to MatchOverviewRouterProtocol
extension MatchOverviewRouter: MatchOverviewRouterProtocol {
    func popViewController() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
