//
//  HomeRouter.swift
//  Sports
//
//  Created by ios Dev on 09/05/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class HomeRouter {
    
    weak var viewController: HomeViewController?

    // MARK: - Init
    init(viewController: HomeViewController) {
        self.viewController = viewController
    }
}
// MARK: Conforming to HomeRouterProtocol
extension HomeRouter: HomeRouterProtocol {
    
    func popViewController() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    
    func navigateToDetails(match: Match) {
        let detailsViewController = MatchDetailsConfigurator.viewController(input: .init(match: match))
        detailsViewController.hidesBottomBarWhenPushed = true
        viewController?.showHero(detailsViewController, navigationAnimationType: .zoomOut)
    }
}
