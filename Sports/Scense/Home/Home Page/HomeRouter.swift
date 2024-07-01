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
        viewController?.showHero(detailsViewController, navigationAnimationType: .pull(direction: .down))
    }
    
    func showFullStory(story: HomeStoryEntity, allStories: [HomeStoryEntity]) {
        let detailsViewController = VideoPlayerConfigurator.viewController(input: .init(videosURLs: ["https://youtu.be/_oTPT3gFUms",
                                                                                                     "https://youtu.be/_oTPT3gFUms",
                                                                                                     "https://youtu.be/_oTPT3gFUms"]))
        detailsViewController.hidesBottomBarWhenPushed = true
        detailsViewController.navigationController?.isNavigationBarHidden = true
        viewController?.showHero(detailsViewController, navigationAnimationType: .pageIn(direction: .up))
    }
    
    func showPostDetails(with post: Post) {
        let postDetailsViewController = PostDetailsConfigurator.viewController(input: .init(post: post))
        postDetailsViewController.hidesBottomBarWhenPushed = true
        // Set the back button title for the current view controller
        let backButton = UIBarButtonItem()
        backButton.title = ""
        viewController?.navigationItem.backBarButtonItem = backButton
        
        viewController?.showHero(postDetailsViewController, navigationAnimationType: .fade)
    }
}
