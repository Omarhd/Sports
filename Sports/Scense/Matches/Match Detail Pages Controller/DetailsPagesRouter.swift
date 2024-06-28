//
//  DetailsPagesRouter.swift
//  Sports
//
//  Created by ios Dev on 24/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class DetailsPagesRouter {
    weak var viewController: DetailsPagesViewController?

    // MARK: - Init
    init(viewController: DetailsPagesViewController) {
        self.viewController = viewController
    }
}
// MARK: Conforming to DetailsPagesRouterProtocol
extension DetailsPagesRouter: DetailsPagesRouterProtocol {
    func popViewController() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
