//
//  MatchH2HRouter.swift
//  Sports
//
//  Created by ios Dev on 24/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MatchH2HRouter {
    weak var viewController: MatchH2HViewController?

    // MARK: - Init
    init(viewController: MatchH2HViewController) {
        self.viewController = viewController
    }
}
// MARK: Conforming to MatchH2HRouterProtocol
extension MatchH2HRouter: MatchH2HRouterProtocol {
    func popViewController() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
