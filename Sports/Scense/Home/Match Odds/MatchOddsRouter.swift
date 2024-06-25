//
//  MatchOddsRouter.swift
//  Sports
//
//  Created by ios Dev on 24/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MatchOddsRouter {
    weak var viewController: MatchOddsViewController?

    // MARK: - Init
    init(viewController: MatchOddsViewController) {
        self.viewController = viewController
    }
}
// MARK: Conforming to MatchOddsRouterProtocol
extension MatchOddsRouter: MatchOddsRouterProtocol {
    func popViewController() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
