//
//  NewsRouter.swift
//  Sports
//
//  Created by ios Dev on 23/05/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class NewsRouter {
    weak var viewController: NewsViewController?

    // MARK: - Init
    init(viewController: NewsViewController) {
        self.viewController = viewController
    }
}
// MARK: Conforming to NewsRouterProtocol
extension NewsRouter: NewsRouterProtocol {
    
    func navigateToDetails(news: News) {
        let detailsViewController = NewsDetailsConfigurator.viewController(input: .init(news: news))
        detailsViewController.hidesBottomBarWhenPushed = true
        viewController?.showHero(detailsViewController, navigationAnimationType: .zoom)
    }
    
    func popViewController() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
