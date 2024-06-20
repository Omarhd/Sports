//
//  MatchDetailsRouter.swift
//  Sports
//
//  Created by ios Dev on 19/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MatchDetailsRouter {
    weak var viewController: MatchDetailsViewController?

    // MARK: - Init
    init(viewController: MatchDetailsViewController) {
        self.viewController = viewController
    }
}
// MARK: Conforming to MatchDetailsRouterProtocol
extension MatchDetailsRouter: MatchDetailsRouterProtocol {
    func popViewController() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
