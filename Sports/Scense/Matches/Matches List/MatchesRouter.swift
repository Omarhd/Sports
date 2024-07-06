//
//  HomeRouter.swift
//  Sports
//
//  Created by ios Dev on 09/05/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MatchesRouter {
    
    weak var viewController: MatchesViewController?

    // MARK: - Init
    init(viewController: MatchesViewController) {
        self.viewController = viewController
    }
}
// MARK: Conforming to HomeRouterProtocol
extension MatchesRouter: MatchesRouterProtocol {
    
    func popViewController() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    
    func navigateToDetails(match: Match) {
        let detailsViewController = MatchDetailsConfigurator.viewController(input: .init(match: match))
        detailsViewController.hidesBottomBarWhenPushed = true
        viewController?.showHero(detailsViewController, navigationAnimationType: .zoomOut)
    }
    
    func navigateToProfile() {
        
    }
    
    func navigateToLogin() {
        let signInViewController = SignInConfigurator.viewController(input: .init())
        let root = CustomNavigationController(rootViewController: signInViewController)
        root.navigationBar.topItem?.backButtonTitle = ""
        viewController?.present(root, animated: true)
    }
}
