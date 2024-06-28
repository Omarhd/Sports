//
//  MomentsRouter.swift
//  Sports
//
//  Created by ios Dev on 27/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MomentsRouter {
    weak var viewController: MomentsViewController?

    // MARK: - Init
    init(viewController: MomentsViewController) {
        self.viewController = viewController
    }
}
// MARK: Conforming to MomentsRouterProtocol
extension MomentsRouter: MomentsRouterProtocol {
    func popViewController() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
