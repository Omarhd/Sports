//
//  NewsDetailsRouter.swift
//  Sports
//
//  Created by ios Dev on 06/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class NewsDetailsRouter {
    weak var viewController: NewsDetailsViewController?

    // MARK: - Init
    init(viewController: NewsDetailsViewController) {
        self.viewController = viewController
    }
}
// MARK: Conforming to NewsDetailsRouterProtocol
extension NewsDetailsRouter: NewsDetailsRouterProtocol {
    func popViewController() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
