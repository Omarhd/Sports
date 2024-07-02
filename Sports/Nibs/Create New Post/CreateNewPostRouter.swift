//
//  CreateNewPostRouter.swift
//  Sports
//
//  Created by ios Dev on 02/07/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class CreateNewPostRouter {
    weak var viewController: CreateNewPostViewController?

    // MARK: - Init
    init(viewController: CreateNewPostViewController) {
        self.viewController = viewController
    }
}
// MARK: Conforming to CreateNewPostRouterProtocol
extension CreateNewPostRouter: CreateNewPostRouterProtocol {
    func popViewController() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
