//
//  PostDetailsRouter.swift
//  Sports
//
//  Created by ios Dev on 27/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class PostDetailsRouter {
    weak var viewController: PostDetailsViewController?

    // MARK: - Init
    init(viewController: PostDetailsViewController) {
        self.viewController = viewController
    }
}
// MARK: Conforming to PostDetailsRouterProtocol
extension PostDetailsRouter: PostDetailsRouterProtocol {
    func popViewController() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
