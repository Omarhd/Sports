//
//  HomeRouter.swift
//  Sports
//
//  Created by ios Dev on 27/06/2024.
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
    
    func showFullImage(image: UIImage) {
        let detailsViewController = ImageViewerViewController(image: image)
        detailsViewController.hidesBottomBarWhenPushed = true
        viewController?.showHero(detailsViewController, navigationAnimationType: .pageIn(direction: .up))
    }
    
    func showFullStory(story: HomeStoryEntity, allStories: [HomeStoryEntity]) {
        print(story)
    }
}
