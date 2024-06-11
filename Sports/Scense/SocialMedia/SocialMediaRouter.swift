//
//  SocialMediaRouter.swift
//  Sports
//
//  Created by ios Dev on 24/05/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class SocialMediaRouter {
    weak var viewController: SocialMediaViewController?

    // MARK: - Init
    init(viewController: SocialMediaViewController) {
        self.viewController = viewController
    }
}
// MARK: Conforming to SocialMediaRouterProtocol
extension SocialMediaRouter: SocialMediaRouterProtocol {
    func popViewController() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
