//
//  TeamDetailsRouter.swift
//  Sports
//
//  Created by ios Dev on 27/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class TeamDetailsRouter {
    weak var viewController: TeamDetailsViewController?

    // MARK: - Init
    init(viewController: TeamDetailsViewController) {
        self.viewController = viewController
    }
}
// MARK: Conforming to TeamDetailsRouterProtocol
extension TeamDetailsRouter: TeamDetailsRouterProtocol {
    func popViewController() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
