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
    
    func showFullImage(image: UIImage) {
        let detailsViewController = ImageViewerViewController(image: image)
        detailsViewController.hidesBottomBarWhenPushed = true
        viewController?.showHero(detailsViewController, navigationAnimationType: .pageIn(direction: .up))
    }
    
    func popViewController() {
        self.viewController?.dismissHero(viewController, navigationAnimationType: .zoomOut)
    }
}
