//
//  LiveRouter.swift
//  Sports
//
//  Created by ios Dev on 20/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class LiveRouter {
    weak var viewController: LiveViewController?

    // MARK: - Init
    init(viewController: LiveViewController) {
        self.viewController = viewController
    }
}
// MARK: Conforming to LiveRouterProtocol
extension LiveRouter: LiveRouterProtocol {
    
    func popViewController() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    
    func navigateToDetails(match: Match) {
        let detailsViewController = MatchDetailsConfigurator.viewController(input: .init(match: match))
        detailsViewController.hidesBottomBarWhenPushed = true
        viewController?.showHero(detailsViewController, navigationAnimationType: .zoomOut)
    }
}
