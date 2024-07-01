//
//  VideoPlayerRouter.swift
//  Sports
//
//  Created by ios Dev on 29/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class VideoPlayerRouter {
    weak var viewController: VideoPlayerViewController?

    // MARK: - Init
    init(viewController: VideoPlayerViewController) {
        self.viewController = viewController
    }
}
// MARK: Conforming to VideoPlayerRouterProtocol
extension VideoPlayerRouter: VideoPlayerRouterProtocol {
    func popViewController() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
